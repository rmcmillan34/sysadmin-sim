# Design Decisions

This document records key architectural and engineering decisions made during the development of the SysAdmin Simulator. Each decision includes context, rationale, and any alternatives considered. Decisions are listed in the order they were made.

---

## [DD-001] Use of YAML for Tickets and Curriculum

### Decision
All tickets, curriculum objectives, and metadata are written in YAML.

### Rationale
- Easy to read and write for both humans and machines
- Well-supported across scripting languages (Python, Bash, etc.)
- Integrates smoothly with configuration and validation tooling

### Alternatives Considered
- JSON (harder to read manually)
- TOML (less widely supported in bash/tooling)

---

## [DD-002] Certification-Aligned Curriculum Mapping

### Decision
Each ticket may include an `objectives_map` that links it to learning objectives from supported certification tracks.

### Supported Exams
- Linux+ (XK0-005)
- LPIC-1 / LPIC-2
- LFCS (2024)

### Rationale
- Ensures traceability between tickets and curriculum outcomes
- Enables objective-based filtering and progress tracking
- Supports future integration with LMS or gamified platforms

### Fields Captured per Objective
- `exam`, `version`, `domain`, `objective_id`, `objective_desc`
- Optional `tools`, `commands`, `files`, `concepts`

---

## [DD-003] Primary Container Registry: GHCR

### Decision
Use **GitHub Container Registry (GHCR)** for automated CI/CD builds. Use **Docker Hub** for manually published public releases.

### Rationale
- GHCR integrates directly with GitHub Actions
- Allows per-repo access control
- Docker Hub is kept clean for major release discoverability

### Registry Strategy
- GHCR: all automated builds (per commit/tag/arch)
- Docker Hub: public stable releases only (manually tagged)

---

## [DD-004] Base Image Versioning Policy

### Decision
Only use the **latest stable major release** of each supported Linux distribution.

### Rationale
- Ensures stable tooling and environment compatibility
- Avoids breakage from rolling, beta, or nightly releases
- Matches how cert environments are structured (e.g., RHCSA)

### Enforcement Strategy
- CI images pinned to stable tags (e.g., `ubuntu:22.04`, `alpine:3.18`)
- No rolling tags like `fedora:latest` or `debian:testing`

---

## [DD-005] Supported Linux Distributions

### Decision
Official containers will be built for the following distributions:

- **Ubuntu** (LTS only)
- **Debian** (latest stable)
- **Fedora** (latest stable)
- **CentOS/Rocky** (latest stable, RHCSA aligned)
- **Alpine** (latest stable)
- **Raspbian** / Raspberry Pi OS *(ARM64 only)*

### Fedora & Rocky Linux Policy

Fedora and Rocky base images are intentionally kept as close to their respective default installs as possible to reflect realistic Red Hat Enterprise Linux (RHEL)-based environments. This decision supports the RHCSA learning path and prevents the accidental use of Debian-specific tools or configs.

- Only native RHEL tools (`dnf`, `firewalld`, `nmcli`, `systemd`) are installed.
- Tools like `lsb_release`, `apt`, or `ufw` are **not** included or expected.
- Tickets targeting these images must be written explicitly for RHEL-compatible behaviors.

This ensures that users are exposed to the actual challenges they'll face in RHEL environments and prevents cross-distro contamination of expectations.

### Rationale
- Covers all major certification families (Debian-based and RHEL-based)
- Ensures compatibility with ARM (e.g., Raspberry Pi)
- Allows distro-specific ticket scenarios (e.g., `dnf`, `firewalld`, `nmcli`)

---

## [DD-006] Ticket Platform Metadata Fields

### Decision
Each ticket may include:
- `compatible_distros`: e.g., `ubuntu`, `alpine`, `rocky`
- `architecture`: e.g., `amd64`, `arm64`

### Rationale
- Prevents execution of tickets on unsupported base images
- Allows CI to group, validate, and build per ticket/distro/arch
- Enables users to filter tickets based on their current environment

---

## [DD-007] Checker Script Distribution + Architecture Validation

### Decision
Checker scripts will validate:
- The running system’s architecture
- The running system’s distribution

If the system does not match, the script exits with an informative error.

### Rationale
- Avoids false negatives during grading
- Provides early exit for misconfigured environments
- Ensures ticket integrity across distro-specific command differences

### Checker Stub
```bash
#!/bin/bash

ARCH=$(uname -m)
DISTRO_ID=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"')
DISTRO_VER=$(grep "^VERSION_ID=" /etc/os-release | cut -d= -f2 | tr -d '"')

echo "Detected: $DISTRO_ID $DISTRO_VER ($ARCH)"

if [[ "$ARCH" != "x86_64" && "$ARCH" != "aarch64" ]]; then
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

if [[ "$DISTRO_ID" != "ubuntu" && "$DISTRO_ID" != "debian" ]]; then
  echo "Unsupported distribution: $DISTRO_ID"
  exit 1
fi
```

---

## [DD-008] Checker Script Language Policy

### Decision
All checker scripts must be written in **Bash**.

### Rationale
- Ensures universal compatibility across all supported distributions
- Requires no additional runtime dependencies (unlike Python, Perl, etc.)
- Keeps validation scripts simple, transparent, and consistent
- Reinforces Bash scripting as a core Linux sysadmin skill (part of Linux+, LFCS)

### Enforcement
- All checker scripts must use the `#!/bin/bash` shebang
- Non-Bash scripts will be flagged as invalid by the validator (planned)

### Alternatives Considered
- Allowing Python (rejected due to inconsistent support across base images)
- Allowing user-defined interpreter field (adds complexity without real benefit)

---

## [DD-009] Dockerfile Naming Convention for Base Images

### Decision
Base Dockerfiles will use the following naming scheme: `Dockerfile.<distro>-base`, and live in the `docker/<distro>/` directory.

### Rationale
- Makes multi-distro pipelines easier to manage in CI/CD
- Avoids collisions with per-ticket Dockerfiles later
- Keeps the file naming aligned with image tags

### Example
- `docker/ubuntu/Dockerfile.ubuntu-base`
- `docker/debian/Dockerfile.debian-base`

---

## [DD-010] Base Image Release Tag Format

### Decision
Base images pushed to GitHub Container Registry (GHCR) will be versioned using the following standardized tag format:

`base-<distro>-<version>-<arch>`

### Examples
- `base-ubuntu-22.04-amd64`
- `base-fedora-39-arm64`
- `base-alpine-3.18-arm64`

### Rationale
- Enables traceability between container versions and ticket compatibility
- Allows image tags to match GitHub Release versions and CI/CD outputs
- Keeps multi-arch and multi-distro support organized and machine-parsable

### Related Documentation
See [`release-plan.md`](release-plan.md) for a full description of the base image tag naming convention and release publishing process.

---

## [DD-011] Randomized Exam Simulation Containers

### Decision
Exam-mode containers will be generated at runtime by dynamically selecting tickets aligned to a target exam's objective distribution.

### Rationale
- Provides realistic, varied cert-style practice
- Enables container reuse while maintaining novelty
- Avoids image bloat from pre-baking static ticket sets
- Supports adaptive learning and exam replayability

### Implementation Notes
- Ticket selection occurs during container startup
- `objectives_map` is used to categorize tickets by domain
- Selection weights are based on official exam domain coverage
- Selected tickets are copied into a temporary workspace
- `check_script` and `setup.sh` are copied or symlinked in

### Related Docs
- [`exam-bundle-spec.md`](./exam-bundle-spec.md) — defines structure of exam manifests and ticket selection
- [`requirements.md`](./requirements.md) → Section **11. Exam Simulation Framework**

---

## [DD-012] Offline Support: Package Installation

### Decision
Tickets that involve package installation must be compatible with offline environments. Containers will not assume access to external package repositories.

### Rationale
- The simulator may be deployed in air-gapped environments or containers with no outbound internet access.
- Ensuring reproducibility of ticket behavior offline improves portability and usability in CTF-style labs, classrooms, and training scenarios.

### Implementation Notes
- Docker images will preload commonly used packages that appear in tickets.
- Optional: a lightweight local package repository may be bundled into the image.
- Package managers (`apt`, `yum`, `dnf`) may be stubbed or wrapped to simulate installation where appropriate.
- Ticket authors should avoid requiring new package installation unless the package is pre-installed.

### Related Metadata Fields
- `requires_package_install: true|false`
- `offline_safe: true|false`

---

## [DD-013] Offline Support: Networking Simulation

### Decision
Tickets that involve networking will use simulated services and loopback interfaces to allow functionality in offline environments.

### Rationale
- Containers may be isolated from the host network or used in restricted labs.
- External hosts (e.g., google.com) cannot be relied on for validation.
- Controlled test environments improve reliability and enable fully offline simulation.

### Implementation Notes
- Use `localhost`, `127.0.0.1`, or Docker-internal interfaces for connectivity tickets.
- Populate `/etc/hosts` with dummy domain names for DNS simulation.
- Allow ticket `setup.sh` scripts to launch local mock services (e.g., netcat or mini HTTP servers).
- Avoid reliance on real-world DNS or external connectivity in all default tickets.

### Related Metadata Fields
- `requires_network: true|false`
- `offline_safe: true|false`

---
