# 📄 Ticket Specification

This document defines the YAML-based structure for **SysAdmin Simulator** tickets. Tickets represent real-world issues that a Linux system administrator might encounter and define the conditions for solving each problem. Tickets are designed to align with certification objectives and track curriculum coverage.

---

## 🧠 Why YAML?

YAML is chosen because it is:
- Human-readable and easy to write
- Natively supported in Python and Go
- Easily validated with schemas
- Ideal for configuration-style definitions like tickets

Each ticket is a `.yaml` file stored in the `/tickets/` directory.

---

## 🏗️ Ticket Schema

| Field           | Type      | Required | Description |
|-----------------|-----------|----------|-------------|
| `id`            | string    | ✅       | Unique ticket identifier (e.g., `ticket-001`) |
| `title`         | string    | ✅       | Short, one-line summary of the problem |
| `difficulty`    | string    | ✅       | One of: `easy`, `medium`, `hard`, `expert` |
| `description`   | string    | ✅       | Detailed multi-line description of the problem |
| `objectives`    | list      | ✅       | List of things the user must achieve or fix |
| `hints`         | list      | ❌       | Optional hints to guide users |
| `timeout`       | integer   | ❌       | Optional time limit in seconds |
| `flag`          | string    | ❌       | Optional flag string (e.g., `LINUX{ssh_config_fixed}`) |
| `tags`          | list      | ❌       | Keywords for categorizing tickets (e.g., `ssh`, `firewall`) |
| `check_script`  | string    | ❌       | Path to a custom checker script for validation |
| `objectives_map`| list      | ❌       | Mappings to one or more certification objectives with exam metadata and associated tools |

---

## ✅ Required Fields

These must be present in every ticket:

```yaml
id: ticket-001
title: "User can't SSH into the server"
difficulty: medium
description: |
  A user reports that they can no longer SSH into the internal web server.
  Investigate and resolve the issue so they can connect again.

objectives:
  - The SSH service must be running
  - The firewall must allow port 22
  - User `webdev` must exist and be in the correct group

```

---

## 🧩 Optional Fields
These enhance the experience or allow integration with systems like CTFd.

```yaml
hints:
  - Use `systemctl status sshd` to check the service
  - Check firewall rules with `iptables` or `ufw`
  - Look at `/etc/ssh/sshd_config`

timeout: 900  # 15 minutes
flag: lnx{sshd_config_fixed}
tags: [ssh, networking, troubleshooting]
check_script: checks/ticket-001-check.sh
```

---

## 🎓 Certification Objective Mapping (objectives_map)
Tickets can optionally be mapped to one or more learning objectives from certification exams. This enables curriculum coverage tracking and integration with learning platforms.

**Supported Exams**
- CompTIA Linux+ (XK0-005)
-LPIC-1 / LPIC-2
- Linux Foundation Certified Sysadmin (LFCS 2024)

**Structure Example**

```yaml
objectives_map:
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
Each ticket may contain multiple mapped objectives from any certification

---

## 📁 Directory Layout

```bash
.
├── tickets/
│   ├── ticket-001.yaml
│   └── ticket-002.yaml
│
├── checks/
│   ├── ticket-001-check.sh
│   └── ticket-002-check.sh
│
├── curriculum/
│   ├── linuxplus.yaml
│   ├── lfcs.yaml
│   ├── lpic1.yaml
│   ├── lpic2.yaml
│   └── rhcsa.yaml
```

---

## 🔐 Flags and CTFd Integration

If a ticket includes a `flag` value, it can be mapped directly to a challenge in CTFd.
During export, this flag is injected into the challenge metadata.

---

## ✅ Best Practices
- Use id values that increment (e.g., ticket-001, ticket-002)
- Avoid spoilers in the `title`
- Write realistic, scenario-based descriptions
- Don’t make flags guessable — only output on success
- Include `objectives_map` for curriculum traceability
- Match difficulty to number of hints and timeout

---

## 🛠️ Future Extensions (Stretch)
- `attachments`: field for files to be included in ticket setup
- `required_packages`: to ensure needed tools are installed
- `services`: to define initial system state (e.g., nginx stopped)

---

## ✅ Example Ticket File (Full)

```yaml
id: ticket-004
title: "Firewall blocks SSH"
difficulty: easy
description: |
  A new developer cannot SSH into their test server. You suspect
  the firewall is blocking port 22. Fix it so that SSH access is restored.

objectives:
  - Port 22 is open in the firewall
  - SSHD is running and enabled

hints:
  - Use `ufw status` or `iptables -L`
  - Restart sshd after changes

timeout: 600
flag: LINUX{firewall_fixed}
tags: [firewall, ssh]
check_script: checks/ticket-004-check.sh

objectives_map:
  - exam: "Linux+"
    version: "XK0-005"
    domain: "2.0"
    objective_id: "2.3"
    objective_desc: "Troubleshoot access and authentication issues"
    tools:
      commands: [ufw, iptables, systemctl]
      files: [/etc/ssh/sshd_config]
      concepts: [firewall rules, service management]

```
