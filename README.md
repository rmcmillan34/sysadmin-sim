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


![Build Base Images](https://github.com/rmcmillan34/sysadmin-simulator/actions/workflows/build-base-images.yml/badge.svg)
                                                                        
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

SSH into the simulator:

```bash
ssh sysadmin@localhost -p 2222
# password: training
```

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

You can pull these directly:

```bash
docker pull ghcr.io/rmcmillan34/sysadmin-sim-ubuntu-base:ubuntu-22.04-amd64
```

---

## 🧪 Contributing

We welcome issues, feature requests, and pull requests!

### Quick links:
- [Setup Guide](docs/setup-guide.md)
- [Ticket Spec](docs/ticket-spec.md)
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
