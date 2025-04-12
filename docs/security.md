# 🔐 Security Considerations

This document outlines the key security mechanisms used in the SysAdmin Simulator project to protect challenge integrity, prevent spoilers, and support safe learning environments. It also details the limits and freedoms granted to the learner within the system.

---

## 🧩 Ticket File Protection and Anti-Spoiler Design

To prevent users from accessing answers directly (e.g., flags, hints, or solutions), the following design choices are implemented:

### 🔒 Restricted Ticket Access

- Ticket YAML files and checker scripts are stored in a protected path:
`/opt/.sys_sim_engine/internal/tickets`

- The directory and files are:
- Owned by `root`
- Set with permissions such that normal users cannot read, write, or list them (`chmod 700`)
- Not accessible via symbolic links or shell auto-completion

### 🧠 Flag and Hint Handling

- Flags and hints are **not included in YAML ticket definitions** unless explicitly required for external integrations.
- They are embedded only in the `check_script` for secure, controlled access.
- This prevents casual browsing or script-based flag scraping.

### 🔐 Optional Encryption (Future Extension)

- In the future, flags and hints may be encrypted using `ENC{}` placeholders, decrypted only during checker runtime.
- This would allow support for partially exposed YAMLs in web-based environments.

---

## 🕵️ Security Through Obscurity (MVP Strategy)

### 🗃️ Obfuscated Directory Structure

- Ticket storage and simulation infrastructure is located in a non-obvious path, such as:
`/opt/.sys_sim_engine/internal/`

- This helps avoid accidental discovery or exploration using `ls`, `find`, or tab-completion.
- All supporting content (scripts, templates, assets) is housed under this root.

### 📁 File Permissions

- Files under this directory are:
- Not world-readable
- Executed or accessed only by privileged simulation runtime components
- This allows check scripts and container services to operate while blocking access from learners.

### ⚠️ Note

While obscurity is **not** a substitute for security, it is a lightweight defense appropriate for MVP environments, educational containers, and non-adversarial use cases.

---

## 🧑‍💻 Simulation User Hardening

To ensure the integrity of the simulation without breaking realism:

### 🔓 Full System Access (No Chroot)

- Learners are **not jailed** to a directory (e.g., `/home/simuser`)
- Instead, they have access to the full Linux filesystem — within the limits of standard non-root privileges
- This enables realistic administration of:
- `/etc`, `/opt`, `/var`, `/mnt`, etc.
- System services
- Mounted volumes
- System logs and package management

### 👤 Unprivileged User Context

- The default simulation user (e.g., `simuser`) is:
- Not part of `sudo`, `wheel`, or any group granting escalation
- Restricted from changing their own UID, creating new users, or modifying core system policies
- Not granted elevated permissions via polkit or DBus

This balance preserves:
- Real-world Linux tooling
- Safe separation of learner and system
- A no-escape, no-spoiler, no-destruction baseline

---

## 🧰 Tool Availability and Sandbox Philosophy

- The container includes a **full Linux toolset**, including:
- Compilers
- Editors
- Debuggers
- Networking and monitoring tools
- Package managers
- No tools are removed, crippled, or restricted
- Learners are encouraged to explore, test, break, and fix

This sandbox is a **learning-first environment**, not a secure appliance or restricted exam engine.

---

## ✅ Summary

This security posture aims to:
- Prevent trivial spoilers (e.g., flag scraping)
- Support realism in system administration tasks
- Harden the simulation runtime without compromising learning

It strikes a balance between **educational integrity**, **practicality**, and **developer velocity**.

---

