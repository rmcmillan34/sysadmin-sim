# 🗺️ SysAdmin Simulator Roadmap

This document outlines planned features, improvements, and stretch goals for the SysAdmin Simulator project.

---

## 🚀 MVP Phase (Minimum Viable Product)

- [x] Multi-arch Docker base images (amd64, arm64)
- [x] Dual SSH service setup (sysadmin + root admin ports)
- [x] Ticket YAML specification and schema finalized
- [x] Checker script MVP using bash
- [ ] Initial set of tickets (multiple choice, command demonstration, scripting, troubleshooting)
- [x] Curriculum mapping for Linux+, LPIC-1, LFCS, RHCSA

---

## 🧩 Stretch Goals (Post-MVP)

- [ ] **Dynamic ticket loading**: Ticket CLI (`ticket-cli`) loads YAML at runtime and handles validation
- [ ] **Dynamic checker scripts**: Checker scripts read objectives from YAML instead of hardcoding solution paths
- [ ] **Gamification**: Leaderboards, points, and badge awards
- [ ] **CTFd Integration**: Export tickets as CTFd-compatible challenges
- [ ] **Dynamic exam bundles**: On container boot, select a random set of tickets simulating an exam session
- [ ] **System snapshot validation**: Complex tickets that require multiple verifications across system state
- [ ] **Distributed deployment**: Host SysAdmin Simulator in cloud/containers for online public challenge events
- [ ] **Web dashboard**: View ticket status, submit flags, and track progress
- [ ] **Automatic ticket generation**: CLI tooling to quickly create ticket YAML/check scripts with templates
- [ ] **SELinux/Hardening sandbox**: Improve isolation and security of learner environment

---

## 🛠️ Future Engineering Ideas

- **Expand to LPIC-2 deep-dive challenges** (DNS, Apache, firewalls)
- **Add challenge types for kernel compilation, device management**
- **Add monitoring-based challenges using tools like `dstat`, `vmstat`, `iotop`**
- **Auto-spawn ticket files during runtime based on difficulty level**

---


