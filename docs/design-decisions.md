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
