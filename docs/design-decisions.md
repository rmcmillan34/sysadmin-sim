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
- RHCSA (9)

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

## [DD-014] Flag Format Standardization

### Decision
All challenge flags will follow the format:

`LINUX{<md5hash>}`

Where `<md5_hash>` is a deterministic **MD5 hash** that uniquely identifies the ticket or result of its solution.

### Rationale
- Ensures consistency with CTF platforms like Hack The Box and CTFd
- MD5 provides a fixed-length (32 characters), fast-to-generate hash
- Guarantees uniqueness while avoiding guessable values
- Professional and clean flag structure suitable for scoring and automation

### Implementation Guidelines
- The MD5 hash must be generated deterministically (e.g., from expected solution state, or some other random variable)
- The `flag` field in the ticket YAML will contain the full `LINUX{md5_hash}` string
- The checker script may emit this flag to indicate success
- Flags must not be guessable, hardcoded, or derived from ticket titles

### Example
```yaml
flag: LINUX{e99a18c428cb38d5f260853678922e03}
```

### Related Fields in ticket schema
- `flag` (defined in each ticket YAML)
- `check_script` (used to validate and optionally output the flag)

---

## [DD-015] Supported Question Types for SysAdmin Simulator
**Decision Date:** 2025-04-27
**Status:** Finalized


### Decision
To ensure that the SysAdmin Simulator effectively covers a wide range of praxtical Linux administration skills aligned with various certification exams, it is necessary to define a set of supported question types. The following question types are supported:

| Type                       | Description |
|----------------------------|-------------|
| **multiple_choice**        | Learner selects the correct answer from provided options (A, B, C, D), writing the answer into a file |
| **manpage_retrieval**      | Learner retrieves a specific piece of information from a man page or help documentation |
| **command_demonstration**  | Learner executes a command or sequence of commands to achieve a specific result |
| **file_manipulation**      | Learner creates, edits, or inspects files according to ticket objectives |
| **scripting**              | Learner writes or modifies a script to automate an administrative task |
| **configuration_fixing**   | Learner edits system configuration files to resolve an issue |
| **system_state_validation**| Learner ensures that a system meets specified conditions (e.g., services running, ports open) |
| **troubleshooting**        | Learner diagnoses and fixes broken services, processes, permissions, or configurations |

Future ticket expansions may introduce additional types if necessary, provided they remain script-checkable.

### Constraints
- All challenge types must be script-checkable to ensure automation and reproducibility.
- Each ticket must specify the `question_type` field in its YAML metadata.
- Challenge types must remain consistent with the definitions documented in `question_types.md` and `ticket_spec.md`.

---

## [DD-016] Checker Script Handling of Solution Paths

**Decision Date:** 2025-04-27
**Status:** Finalized

### Context:
Each ticket specifies the expected solution file path (for multiple choice answers, command outputs, etc.) in its YAML structure, usually under the `objectives` field.

At MVP stage, checker scripts are kept lightweight and bash-only. Therefore, reading YAML dynamically inside checkers is deferred to maintain simplicity and robustness across distributions.

### Decision:
- Checker scripts will **hardcode** the expected solution file path during the MVP phase.
- Authors must manually synchronize the path between the ticket YAML (`objectives`) and the corresponding checker script.
- Future versions may support dynamic parsing of ticket YAMLs via a `ticket-cli` or similar management tool.

### Constraints:
- Hardcoded paths must match the `objectives` field of their corresponding ticket YAML exactly.
- Stretch goal: Refactor checkers to dynamically parse YAML using `yq`, `ticket-cli`, or equivalent tooling once MVP stability is achieved.

---

## [DD-017] Ticket Setup and Strikedown Scripts

**Decision Date:** 2025-04-29
**Status:** Finalized

### Context:
Some tickets require the system to be in a specific prepared state before a user attempts the challenge (e.g., background processes running, misconfigured services, corrupted filesystems). Similarly, after completion, the environment may need cleanup to avoid interfering with future tickets.

Previously, all tickets assumed a static environment. As the simulator evolves to cover deeper real-world skills, dynamic ticket environments are required.


### Decision:
Each ticket may include two optional scripts:

- `setup_script`: A bash script that is executed immediately before the ticket starts to setup necessary system conditions. This script may create files, start/stop services, or modify configurations to prepare the system for the challenge.

- `strikedown_script`: A bash script that is executed immediately after the ticket is completed (success, failure, or timeout) to clean up any changes made during the challenge. This script may remove files, stop services, or revert configurations to restore the system to its original state.

These scripts are referenced by relative path within the ticket YAML definition.

If the scripts are not present, the ticket will run without any setup or teardown, as the challenged is presumed to be static.


### Constraints:
- Scripts must be self-contained and idempotent (able to run multiple times safely).
- Scripts must clean up all resources they create (e.g., processes, temporary files).
- Setup/strikedown scripts must be bash-compatible across supported distributions (Ubuntu, Debian, Fedora, Rocky, Alpine, RaspiOS).
- Setup scripts must be designed to avoid interfering with unrelated system functionality.
- Execution of setup/strikedown scripts must be controlled by the simulation engine (`ticket-cli` or equivalent).


### Example Usage:
```yaml
setup_script: "setup/ticket-017-setup.sh"
strikedown_script: "setup/ticket-017-strikedown.sh"
```

---

## [DD-018] Countdown Timer for Ticket Challenges.

**Decision Date:** 2025-05-10
**Status:** Finalized  

### Context:
The SysAdmin Simulator aims to simulate real-world pressure when solving administrative problems. A visual countdown timer enhances realism and helps learners manage time effectively in the exam scenario. However, certain tickets may benefit from a more subtle or absent timer display.

### Decision:
- The simulator will have a **countdown timer as a default feature**.  
- By default, the timer will display **both in the shell prompt and as a background notification**.  
- A **global configuration file** (`/etc/sim-config.yaml`) will specify the default behavior:
  ```yaml
  timer_display: "both"  # default, prompt, background, none
  ```
  This can optionally be set by the player on startup to customise their experience.

- Tickets may optionally override this using a timer_display field within their `ticket-XXX.yaml`.

**Valid Values**
`both`: Displays within the terminal prompt and as a background noticfication via `wall`
`prompt`: Only displays the time remaining within the users terminal prompt.
`background`: Only notifications will be given regularly via the `wall` command
`none`: No timer notifications will be given for this ticket.

### Constraints:
- Global configuration to be utilised as priority
- Timer should not disrupt active command input
- Timer script must be light weight and responsive to minimise shell lag
- On completion or ticket cancellation timer should clear automatically as a task of the strikedown script.

### Future considerations:
- Potentially allow users to decrease the ticket time via difficulty settings

---

## [DD-019] User Configuration Menu and Runtime Ticket Selection

**Decision Date:** 2025-05-10  
**Status:** Finalized  

### Context:
To increase user flexibility based on their requirements and mirror real-world sysadmin scenarios, the simulator should allow users to choose their learning mode, timer settings, and target exam upon login. This also avoids creating multiple container images for each exam type.

### Decision:
- Upon first login to the simulator, or by a command, the user is presented with a **menu** to configure their simulation/run experience.
- Options include:
    - Game mode (Exam mode (Specific certification question distribution), Random Challenges (Configurable number), Continuous Play)
    - Timer settings (prompt, background, both, none, or per ticket)
    - Difficulty level (easy, medium, hard)
- Chosen settings will be stored in a **user specific configuration file**:
    `~/.config/sysadmin-simulator/config.yaml`
- The menu is triggered by:
    - First login
    - Running the sysadmin-simulator config command
    ```bash
    sysadmin-sim config
    ```
- Tickets are filtered `dynamically` based on the user option selection.

### Constraints:
- All tickets will be loaded to the container on build, only relevant tickets will be selected at runtime
- The configuration should be **user-specific** to allow for multi user sessions on the same container.
- The system must gracefully revert to default settings if the configuration file is missing or corrupted

### Future Considerations:
- Allow for saving of multiple custom configuratons for quick swapping
- Suport **multi-player environments** with per player configurations.

---

## [DD-020] Simplified Docker Tagging Format

**Decision Date:** 2025-05-11
**Status:** Finalized

### Context:
The original Docker image tags were verbose and cumbersome, including the base suffix and detailed version numbers. This led to increased typing effort and a less intuitive user experience.
Incorporation of all ticket IDs into the image means there will only be one image per ticket, so the tag format should be simplified to reflect this. This decision supercedes `DD-009`.

### Decision:
- Use the following simplified tag formats for all distributions and architectures:
  
```bash
ghcr.io/rmcmillan34/sysadmin-sim-<distro>-<arch>
ghcr.io/rmcmillan34/sysadmin-sim-<distro>-latest
ghcr.io/rmcmillan34/sysadmin-sim-<distro>:latest-<arch>  
```

- This change applies to all supported distributions and architectures:
    - Ubuntu, Debian, Fedora, Rocky, Alpine, RaspiOS

### Implementation:
- Update GitHub Actions workflows to use the simplified tag format.
- Update Dockerfiles to reflect the new naming convention.
- Validate the updated tags by pulling and running the images after a successful build.

### Benefits:
- Streamlines image management.
- Reduces complexity in typing and remembering tags.
- Aligns with common practices used by official Docker Hub images.

---

## [DD-021] Standardised File Structure for SysAdmin Simulator Docker Containers

**Decision Date:** 2025-05-11
**Status:** Finalized

### Context:
The current file structure of the SysAdmin Simulator lacks standardization and consistency, leading to confusion when accessing scripts and configuration files. As the project scales, it becomes increasingly important to have a clear and organized file structure.

### Decision:
- To standardise the file structure within the SysAdmin Simulator Docker containers, the following directory structure will be implemented:

#### Scripts Location
- All executable scripts for the simulator will be located in `/bin/sysadmin-sim/`
- This location follows the **Linux Filesystem Hierarchy Standard (FHS)** for storing executable binaries and scripts.  
- Scripts will be made executable and accessible via `$PATH`.

#### Configuration Files Location
- All configuration files for the simulator will be located in `/etc/.sysadmin-sim/`
- This follows the FHS for storing system-wide configuration files.
- Configuration files will be read-only for users and only modifiable by the root user or via the simulator's configuration menu.

### Implementation:

- Update the **Dockerfile** to:
- Create the directory structure:
  ```dockerfile
  RUN mkdir -p /bin/sysadmin-sim /etc/.sysadmin-sim
  ```
- Copy all relevant scripts to `/bin/sysadmin-sim/`.
- Copy configuration files to `/etc/.sysadmin-sim/`.
- Update environment variables to include:
  ```bash
  export PATH="/bin/sysadmin-sim:$PATH"
  ```

- Update **Entrypoint and Setup Scripts** to reference the new paths.

- Ensure the sysadmin user's **`.bashrc`** includes:
  ```bash
  export PATH="/bin/sysadmin-sim:$PATH"
  ```

### Constraints:

- The system must ensure that the `/bin/sysadmin-sim/` directory is part of the `$PATH` to allow running the program from anywhere.  
- Any script that relies on configuration data must be adapted to look in the new configuration directory (`/etc/.sysadmin-sim/`).  
- The sysadmin user's **`.bashrc`** should include the updated path.  

### Benefits:

- Aligns with **Linux filesystem best practices**.  
- Ensures **clear separation** of binaries and configuration files.  
- Reduces **path confusion** when calling simulator scripts from various environments (local shell, SSH, etc.).  
- Easier to document and maintain as the project scales.  

### Future Consideration:

- If multi-user support is introduced, consider adding a **user-specific configuration directory** in addition to the system-wide one.  

---

## [DD-022] 
