   ▄████████ ▄██   ▄      ▄████████    ▄████████ ████████▄    ▄▄▄▄███▄▄▄▄    ▄█  ███▄▄▄▄                
  ███    ███ ███   ██▄   ███    ███   ███    ███ ███   ▀███ ▄██▀▀▀███▀▀▀██▄ ███  ███▀▀▀██▄              
  ███    █▀  ███▄▄▄███   ███    █▀    ███    ███ ███    ███ ███   ███   ███ ███▌ ███   ███              
  ███        ▀▀▀▀▀▀███   ███          ███    ███ ███    ███ ███   ███   ███ ███▌ ███   ███              
▀███████████ ▄██   ███ ▀███████████ ▀███████████ ███    ███ ███   ███   ███ ███▌ ███   ███              
         ███ ███   ███          ███   ███    ███ ███    ███ ███   ███   ███ ███  ███   ███              
   ▄█    ███ ███   ███    ▄█    ███   ███    ███ ███   ▄███ ███   ███   ███ ███  ███   ███              
 ▄████████▀   ▀█████▀   ▄████████▀    ███    █▀  ████████▀   ▀█   ███   █▀  █▀    ▀█   █▀               
                                                                                                        
   ▄████████  ▄█    ▄▄▄▄███▄▄▄▄   ███    █▄   ▄█          ▄████████     ███      ▄██████▄     ▄████████ 
  ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ ███    ███ ███         ███    ███ ▀█████████▄ ███    ███   ███    ███ 
  ███    █▀  ███▌ ███   ███   ███ ███    ███ ███         ███    ███    ▀███▀▀██ ███    ███   ███    ███ 
  ███        ███▌ ███   ███   ███ ███    ███ ███         ███    ███     ███   ▀ ███    ███  ▄███▄▄▄▄██▀ 
▀███████████ ███▌ ███   ███   ███ ███    ███ ███       ▀███████████     ███     ███    ███ ▀▀███▀▀▀▀▀   
         ███ ███  ███   ███   ███ ███    ███ ███         ███    ███     ███     ███    ███ ▀███████████ 
   ▄█    ███ ███  ███   ███   ███ ███    ███ ███▌    ▄   ███    ███     ███     ███    ███   ███    ███ 
 ▄████████▀  █▀    ▀█   ███   █▀  ████████▀  █████▄▄██   ███    █▀     ▄████▀    ▀██████▀    ███    ███ 
                                             ▀                                               ███    ███ 


[![Build Base Images](https://github.com/rmcmillan34/sysadmin-sim/actions/workflows/build-base-images.yml/badge.svg)](https://github.com/rmcmillan34/sysadmin-sim/actions/workflows/build-base-images.yml)
                                                                        
**SysAdmin Simulator** is a command-line based Linux learning environment where you solve realistic system administration tickets — just like a real sysadmin. Practice your Linux+, LPIC, LFCS, and RHCSA skills by troubleshooting live systems, navigating user requests, and solving challenges that simulate real-world Linux issues.

---

## 📦 Features

- 🧾 Simulated helpdesk-style tickets
- ⌨️ All interactions via CLI (SSH, TUI, or terminal)
- 🧠 Supports Linux+, LPIC-1/2, LFCS, and RHCSA curricula
- 🐳 Hybrid Docker support (local & CTFd)
- 🔐 Sandbox-safe environments per ticket
- 🧩 Built-in hints, difficulty levels, and timers
- 🏁 Optional gamification and flag system (CTFd-ready)

---

## 🚀 Getting Started

> Quickly try it out locally.

### Prerequisites

- Docker (with Buildx support)
- Linux or WSL/WSA (for SSH access)
- Git

### Clone and Run (Quickstart)

```bash
git clone https://github.com/yourname/sysadmin-simulator.git
cd sysadmin-simulator
docker compose up
```

---

## 🔐 Accessing the Simulator

Once your container is running, you can access the simulator in two ways:

### 🧪 Local Shell Access

If you run the container interactively:

```bash
docker run -it ghcr.io/rmcmillan34/sysadmin-sim-ubuntu-base:ubuntu-22.04-amd64
```

You’ll be dropped directly into a shell as the `sysadmin` user:

- **Username:** `sysadmin`
- **Password:** *(not required for local shell)*

### 🌐 Remote SSH Access

If you expose the container’s SSH ports, you can connect via SSH in two modes:

| Mode             | Username | Password   | Port  | Purpose     |
|------------------|----------|------------|-------|-|
| **Player Mode**   | `sysadmin` | `sysadmin` | `2222` | Solve tickets and train Linux skills  |
| **Admin Mode**    | `root`     | `adminroot` | `2223` | Administer or debug the environment   |

```bash
# Player login (recommended)
ssh sysadmin@localhost -p 2222

# Admin/maintenance login
ssh root@localhost -p 2223

```

> ⚠️ These default credentials are for development/testing only. You should override them in production deployments.

---

Start solving tickets:

```bash
ticket-cli list
ticket-cli start ticket-001
```

---

## 📂 Directory Structure

```
.
├── tickets/          # YAML ticket definitions
├── checks/           # Per-ticket checker scripts
├── curriculum/       # Curriculum YAMLs for Linux+, LPIC, RHCSA, LFCS
├── docker/           # Dockerfiles for base and ticket images
├── ticket-cli/       # Source for the CLI tool
├── scripts/          # Utilities, export-to-ctfd, etc.
├── docs/             # Engineering documentation
└── README.md
```

---

## 📚 Curriculum Mapping

Supported certifications:

- ✅ Linux+ (XK0-005)
- ✅ LPIC-1 and LPIC-2
- ✅ Red Hat RHCSA
- ✅ Linux Foundation LFCS (2024)

Tickets are mapped to learning objectives with:
- Exam name, version, domain, and objective ID
- Descriptions
- Related tools, commands, concepts, and config files

See full mapping in [ticket-spec.md](docs/ticket-spec.md).

---

## 🐳 Docker Modes

| Mode        | Description                                    |
|-------------|------------------------------------------------|
| **Local**   | All tickets inside one container               |
| **CTFd**    | One container per ticket (for gamified use)    |
| **Hybrid**  | Supports both for dev/test/CTF environments    |

Releases include multi-arch builds (`amd64`, `arm64`).

---

## 🐳 Base Docker Images

The simulator uses per-distro base images to create clean, reproducible learning environments.

Base images are hosted on [GitHub Container Registry (GHCR)](https://ghcr.io) and tagged by distro, version, and architecture.

### Example Tags

| Distro  | Arch   | Tag |
|---------|--------|-----|
| Ubuntu  | amd64  | `ghcr.io/rmcmillan34/sysadmin-sim-ubuntu-base:ubuntu-22.04-amd64` |
| Ubuntu  | arm64  | `ghcr.io/yrmcmillan34/sysadmin-sim-ubuntu-base:ubuntu-22.04-arm64` |
| Debian  | amd64  | `ghcr.io/rmcmillan34/sysadmin-sim-debian-base:debian-12-amd64` |
| Debian  | arm64  | `ghcr.io/rmcmillan34/sysadmin-sim-debian-base:debian-12-arm64` |
| Rocky   | amd64  | `ghcr.io/rmcmillan34/sysadmin-sim-rocky-base:rocky-9-amd64` |
| Rocky   | arm64  | `ghcr.io/rmcmillan34/sysadmin-sim-rocky-base:rocky-9-arm64` |
| Alpine | amd64  | `ghcr.io/rmcmillan34/sysadmin-sim-alpine-base:alpine-3.18-amd64` |
| Alpine | arm64  | `ghcr.io/rmcmillan34/sysadmin-sim-alpine-base:alpine-3.18-arm64` |
| Fedora  | amd64  | `ghcr.io/rmcmillan34/sysadmin-sim-fedora-base:fedora-39-amd64` |
| Fedora  | arm64  | `ghcr.io/rmcmillan34/sysadmin-sim-fedora-base:fedora-39-arm64` |
| Raspbian | arm64  | `ghcr.io/rmcmillan34/sysadmin-sim-raspbian-base:raspbian-12-arm64` |

You can pull these directly:

```bash
docker pull ghcr.io/rmcmillan34/sysadmin-sim-ubuntu-base:ubuntu-22.04-amd64
```

### 📦 Pulling Specific Versions from GitHub Packages
To view or pull a specific version of a base image:

1. Visit the GHCR package listing
2. Select the tag/version you want to pull
3. Use the docker pull command provided for that tag, for example:

```bash
docker pull ghcr.io/rmcmillan34/sysadmin-sim-<distribution-base:<distribution-<version-<architecture>
```
These builds are automatically updated via GitHub Actions on each push to main.

---

## Configuing SysAdmin Simulator
The Sysadmin Simulator configuration script will run when you first login. Otherwise you can run it at any time by running the following command:

```bash
sysadmin-sim config
```

Your settings mid run will be saved to the following file:

```bash
~/.config/sysadmin-sim/config.yaml
```

In the configurator you can set the following options:

- **Game Mode**: Exam, Random, or Continuous play
- **Exam Target**: Linux+, LPIC-1, LPIC-2, RHCSA, LFCS
- **Difficulty**: Easy, Medium, Hard
- **Timer Display**: Prompt, background, both, none, or per ticket specification

---

## 🧪 Contributing

We welcome issues, feature requests, and pull requests!

### Quick links:
- [Setup Guide](docs/setup-guide.md)
- [Developer Ticket Spec](docs/ticket-spec.md)
- [Contributing Guidelines](docs/contributing.md)

---

## 🧠 Future Plans

- Web dashboard for tracking
- Leaderboards and achievements
- RHCSA, LPIC-2 expansions
- More gamified challenge modes

See full roadmap: [roadmap.md](docs/roadmap.md) (TODO)

---

## 📜 License

MIT License – free to use, fork, and contribute!

---

## 🧵 Acknowledgements

Inspired by real sysadmin tasks and the open-source training community.
