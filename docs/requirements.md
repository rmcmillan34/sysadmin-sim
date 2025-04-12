# SysAdmin Simulator – Requirements Documentation

---

## 1. Purpose

**SysAdmin Simulator** is a command-line based Linux training tool designed to simulate real-world system administration workflows. Users receive and resolve simulated support tickets using real Linux commands in a sandboxed environment. The goal is to prepare learners for certifications like Linux+, LPIC, and LFCS while developing practical, hands-on skills.

---

## 2. Target Audience

- Aspiring Linux system administrators
- Students preparing for certifications (Linux+, LPIC-1/2, LFCS, RHCSA)
- Bootcamp participants and classroom learners
- Hobbyists and career switchers looking to sharpen Linux CLI skills
- CTF organisers or players looking to test their skills.

---

## 3. Goals

- Provide immersive, ticket-driven Linux training
- Align all content with Linux+, LPIC, and LFCS exam objectives
- Allow users to learn via the CLI (SSH, terminal, or TUI)
- Provide hints, timers, and progressive difficulty levels
- Offer automated solution validation
- Enable multi-platform, containerized deployment

---

## 4. Functional Requirements

### 4.1 Ticket System
- Tickets are written in YAML and stored in `/tickets/`
- Each ticket includes:
  - ID, title, description, difficulty
  - Objectives and solution expectations
  - Associated checker script
  - Optional hints and timers
  - Mappings to exam objectives

### 4.2 CLI Tool (`ticket-cli`)
- List available tickets
- View ticket details
- Start and reset ticket environments
- Submit and check solutions
- View hints progressively

### 4.3 Notification System
- A root-level service monitors for new tickets
- Alerts users via `wall`, direct TTY messaging, or optional TUI
- Tracks TTY sessions to target logged-in users
- Tickets appear in simulated inbox or mailbox

### 4.4 Solution Evaluation
- Each ticket has an associated check script
- Scripts return pass/fail and may output a `flag`
- Results are logged in user history
- Tickets may be retryable or reset

### 4.5 Progress Tracking
- Track completed tickets per user
- Optional gamification (XP, badges, difficulty scores)
- History stored locally (`~/.ticket-sim/`)

---

## 5. Non-Functional Requirements

- Runs fully offline
- CLI-first (no GUI required)
- Lightweight and portable (Docker-based)
- Sandbox isolation per ticket
- Versioned ticket and exam mappings

---

## 6. Technical Stack

- Bash & Python for CLI tooling and validators
- Docker & Docker Compose for containerized environments
- Optional: `dialog`, `fzf`, or `rich` for TUI support
- Systemd or cron for background services
- YAML for ticket and curriculum definitions

---

## 7. Stretch Goals

- Web dashboard (read-only) for progress tracking
- Leaderboards and multiplayer/team mode
- Objective coverage reports
- Integration with a learning management system (LMS)
- Real email simulation for ticket delivery
- Git-based ticket versioning and author attribution

---

## 8. CTFd Integration

The project is built to support CTFd from day one.

### 8.1 Integration Features
- Tickets can be exported as CTFd-compatible challenges
- Checker scripts can output flags
- Tickets support `flag:` metadata
- Support for per-ticket containers

### 8.2 Supported Modes
- Local CLI play (sandboxed)
- CTFd deployment (Docker per challenge)

### 8.3 Export Tools (Planned)
- Script to convert tickets to CTFd JSON or sync via API
- Containerized delivery for CTFd hosting

---

## 9. Docker and Multi-Architecture Support

The simulator uses a **hybrid Docker model**:

### 9.1 Local Mode
- One container includes all tickets and CLI tools
- Users can solve tickets sequentially

### 9.2 CTFd Mode
- Each ticket is packaged in its own Docker container
- Derived from a shared base image (`sysadmin-sim:base`)
- Used for per-challenge sandboxing

### 9.3 Architecture Support
- Supports `linux/amd64` and `linux/arm64`
- Built using GitHub Actions and Docker Buildx

### 9.4 Releases
- Docker images attached to GitHub Releases
- Tagged by version, architecture, and distribution
- Includes base image and per-ticket images

### 9.5 Registry Strategy and Release Management

This project uses a hybrid registry strategy to support CI automation and public discoverability:

- ✅ **GitHub Container Registry (GHCR)**:  
  Used for automated multi-architecture builds via GitHub Actions. All tagged releases and branch builds are published here.
  - Versioned containers per ticket and per base image
  - Aligned with GitHub Releases and CI/CD

- ✅ **Docker Hub**:  
  Reserved for **manual uploads of major public releases**. This makes it easier for external users to find and pull containers with minimal configuration.

| Purpose                  | GHCR                  | Docker Hub           |
|--------------------------|-----------------------|----------------------|
| CI/CD automation         | ✅ Fully integrated    | ❌ Manual setup only |
| Pull limits              | ✅ Higher for GitHub users | ⚠️ Rate limited     |
| Public discoverability   | Moderate              | ✅ High              |
| Scope granularity        | Per-repo + org access | Public/private only |
| Use case                 | Development/testing   | Production/public    |

---

### 9.6 Supported Linux Distributions

Tickets and base images are built on a defined set of supported distributions to ensure consistency across testing and challenge environments.

| Distribution    | Purpose                                    | Notes                     |
|------------------|--------------------------------------------|----------------------------|
| **Ubuntu (LTS)** | ✅ Default base image                       | Only Long-Term Support releases |
| **Debian**       | ✅ General compatibility, apt-based         | Stable and universal       |
| **Fedora**       | ✅ RHCSA-aligned platform                   | Latest packages, dnf-based |
| **CentOS/Rocky** | ✅ RHCSA-compatible legacy support          | Long-term RH-like behavior |
| **Alpine**       | ⚠️ Minimal image for tight environments     | Not all GNU tools available |
| **Raspbian**     | ✅ Raspberry Pi target (ARM64 only)         | Official Pi OS if not Raspbian |

Raspbian (or Raspberry Pi OS) is assumed to be ARM64-only for simplicity.

Each ticket will declare its compatible base image using the `compatible_distros` field. Only tickets that work for a given container's distro should be run in that environment.

---

### 9.7 Base Distibution Release Policy

To ensure stability and consistency, all container images must use the latest **stable, non-rolling** major release of each supported distribution. This applies to all supported distros — not just Ubuntu.

| Distribution | Policy                                     |
|--------------|--------------------------------------------|
| Ubuntu       | Use only Long-Term Support (LTS) releases  |
| Debian       | Use only the latest stable release         |
| Fedora       | Use only the latest stable major release   |
| Rocky/CentOS | Use latest stable from supported branches  |
| Alpine       | Use the latest stable major release        |
| Raspbian     | Use latest official Raspberry Pi OS (64-bit)

Rolling, beta, nightly, or edge releases are **explicitly not supported** to avoid compatibility drift and tooling inconsistency.

---

### 9.8 Checker Script Validation Specification (Planned)

Each ticket's checker script will be extended to:
- Detect the running architecture (`amd64`, `arm64`)
- Detect the distribution (`lsb_release`, `/etc/os-release`)
- Exit early or warn if the script is being run in an unsupported container environment

This will be formally defined in `docs/checker-script-spec.md` (to be created).

```bash
#!/bin/bash
ARCH=$(uname -m)
DISTRO=$(grep "^ID=" /etc/os-release | cut -d= -f2)

if [[ "$ARCH" != "x86_64" && "$ARCH" != "aarch64" ]]; then
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

if [[ "$DISTRO" != "ubuntu" && "$DISTRO" != "debian" ]]; then
  echo "Unsupported distribution: $DISTRO"
  exit 1
fi
```

---

## 10. Learning Objective Mapping

Tickets can be explicitly aligned to certification objectives. This supports traceability, coverage tracking, and guided curriculum development.

### 10.1 Supported Certifications

- ✅ CompTIA Linux+ (XK0-005)
- ✅ LPIC-1 / LPIC-2
- ✅ Linux Foundation Certified Sysadmin (LFCS 2024)
- 🕐 Red Hat RHCSA (planned)

### 10.2 Mapping Format (in Ticket YAML)

```yaml
objectives:
  - exam: "LFCS"
    version: "2024"
    domain: "1"
    objective_id: "1.2"
    objective_desc: "Diagnose, identify, manage, and troubleshoot processes and services"
    tools:
      commands: [ps, systemctl]
      files: [/etc/systemd, /var/log/messages]
      concepts: [process management, service state]
```

Each ticket may include multiple mappings. Exam domains and learning objectives are stored centrally in:

```bash
.
/curriculum/
├── linuxplus.yaml        # CompTIA Linux+ XK0-005
├── lfcs.yaml             # Linux Foundation Certified Sysadmin
├── rhcsa.yaml            # Red Hat Certified System Administrator EX200 (planned)
├── lpic1.yaml            # LPIC-1 (in progress)
└── lpic2.yaml            # LPIC-2 (planned)

```

### 10.3 Skills, Tools and Files

Metadata for the concepts, skills and tools required to solve the ticket. The categories can be defined as follows:

| Field | Description |
|-------|-------------|
|`commands`| CLI commands (e.g., `ls`, `systemctl`)|
|`files`| System or config files required to view or edit|
|`concepts`|High level topics the objective touches on|

---

## 11. Directory Layout
```bash
.
├── tickets/                 # YAML ticket definitions
│   ├── ticket-001.yaml
│   ├── ticket-002.yaml
│   └── ...
│
├── checks/                 # Per-ticket validation/check scripts
│   ├── ticket-001-check.sh
│   └── ...
│
├── scripts/                # Ticket tools, validators, reporting
│   ├── generate_ticket.py
│   ├── validate_ticket.py
│   └── report_objective_coverage.py  # (optional)
│
├── curriculum/             # Certification objective mappings
│   ├── linuxplus.yaml
│   ├── lfcs.yaml
│   ├── lpic1.yaml
│   ├── lpic2.yaml
│   └── rhcsa.yaml
│
├── docs/                   # Engineering and user documentation
│   ├── requirements.md
│   ├── ticket-spec.md
│   └── ...
│
├── docker/                 # Dockerfiles for base image & per-ticket builds
│   ├── Dockerfile.base
│   ├── Dockerfile.ticket-001
│   └── ...
│
└── README.md               # Main project readme
```
## 11. Exam Simulation Framework

The system must support auto-generated exam simulation containers. These containers will:

- Randomly select a set of tickets from the global pool
- Respect the objective distribution per exam (e.g., Linux+, LPIC-1)
- Include only tickets tagged with matching `objectives_map.exam`
- Copy in all required `check_script` and `setup.sh` files
- Generate an `exam.yaml` manifest describing the ticket order and objectives
- Present users with a time-limited terminal challenge session (e.g., 90 minutes)

Ticket selection will occur each time the container is started, enabling randomized challenge sessions aligned to the exam objectives.

The selection engine will use:
- Ticket metadata from YAML (`objectives_map`)
- Predefined exam domain weights
- Dynamic script-based filtering and packaging

This feature supports future deployment as practice cert exams, scored containers, or formal assessments.

