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
