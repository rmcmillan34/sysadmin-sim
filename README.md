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
                                                                                                                                                                 
A System administrator simulator to learn Linux concepts for basic Linux certifications such as the Linux+ or LPIC-1/2

## 📦 Features

- 🧾 Simulated helpdesk-style tickets
- ⌨️ All interactions via CLI (SSH, TUI, or terminal)
- 🧠 Supports Linux+ and LPIC-1/2 curriculum
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

```bash
.
├── tickets/          # YAML ticket definitions
├── checks/           # Per-ticket checker scripts
├── docker/           # Dockerfiles for base and ticket images
├── ticket-cli/       # Source for the CLI tool
├── scripts/          # Utilities, export-to-ctfd, etc.
├── docs/             # Engineering documentation
└── README.md
```

---

## 📚 Curriculum Mapping

- Linux+ (TODO)
- LPIC-1 (TODO)
- LPIC-2 (TODO)
- Red Hat RHSCA (TODO)

---

## 🐳 Docker Modes

|--|--|
|Mode|Description|
|Local| All tickets inside one container|
|CTFd| One Container per ticket (for gamified use)|
|Hybrid|Supports both for dev/test/CTF environments|

Releases include multi-arch builds (`amd64`,`arm64`).

---

## 🧪 Contributing
We welcome issues, feature requests, and pull requests!

**Quick links:**
- Setup Guide
- Ticket Spec
- Contributing Guidelines

---

## 📚 Documentation

- [Requirements](docs/requirements.md)
- [System Architecture](docs/architecture.md)
- [Ticket Spec](docs/ticket-spec.md)
- [CTFd Integration](docs/ctfd-integration.md)
- [Setup Guide](docs/setup-guide.md)
- [Contributing Guide](docs/contributing.md)

---

## 📜 License
[MIT License](LICENSE) – free to use, fork, and contribute!

