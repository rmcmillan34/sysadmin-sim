# 📘 User Stories by Certification Objective

This document captures high-level user stories for each certification objective across supported Linux certifications. These user stories can be used as the foundation for designing realistic, objective-aligned SysAdmin Simulator tickets.

---

## 🧪 Linux+ XK0-005

### 🧩 Domain 1.0 – System Management

**1.1 – User and Group Permissions**
> As a junior Linux administrator, I want to change file ownership using `chown` and set group permissions with `chmod`, so that team members can collaborate on shared directories without compromising file security.

**1.2 – Job Scheduling**
> As a junior Linux administrator, I want to configure a recurring backup script using `crontab`, and verify it's scheduled correctly using `crontab -l`, so that I can automate periodic maintenance tasks.

**1.3 – Linux Devices**
> As a junior Linux administrator, I want to list and mount block devices using `lsblk` and `mount`, so that I can attach external storage to the system and ensure accessibility.

**1.4 – Basic Linux Operations**
> As a junior Linux administrator, I want to use commands like `ls`, `cd`, `mkdir`, and `cp` to navigate the filesystem and manage files, so that I can perform everyday shell operations confidently.

**1.5 – Linux Boot Process**
> As a junior Linux administrator, I want to troubleshoot a failed boot using GRUB recovery mode and check `journalctl` logs, so that I can recover a system after a kernel failure or misconfiguration.

**1.6 – Install and Use Linux Software**
> As a junior Linux administrator, I want to use `apt`, `yum`, or `dnf` to install and remove packages, so that I can manage system software in different distributions.

---

### 🔐 Domain 2.0 – Security

**2.1 – Access and Authentication**
> As a junior Linux administrator, I want to configure password aging policies and manage SSH keys, so that I can secure user accounts and remote access.

**2.2 – Logging and Auditing**
> As a junior Linux administrator, I want to analyze authentication and system logs using `journalctl` and `/var/log/secure`, so that I can detect potential unauthorized activity.

**2.3 – Firewalls and Access Control**
> As a junior Linux administrator, I want to configure `ufw` or `firewalld` to allow or deny traffic on specific ports, so that I can control network access to services.

**2.4 – File Integrity and Permissions**
> As a junior Linux administrator, I want to set special permissions using `setuid`, `setgid`, and `sticky bits`, so that I can protect shared directories from unauthorized file deletions or privilege escalation.

**2.5 – Backup and Restore**
> As a junior Linux administrator, I want to create compressed backups using `tar` and restore files from archives, so that I can recover from accidental data loss or system changes.

---

### 🔧 Domain 3.0 – Linux Troubleshooting and Diagnostics

**3.1 – Use Basic Linux Commands**
> As a junior Linux administrator, I want to use commands like `df`, `du`, `ps`, `top`, and `free` to check disk, CPU, and memory usage, so that I can monitor system health and diagnose performance issues.

**3.2 – Troubleshoot User and Group Issues**
> As a junior Linux administrator, I want to investigate user login issues, missing home directories, or incorrect shell assignments using `/etc/passwd` and `id`, so that I can resolve access problems.

**3.3 – Troubleshoot Application and Service Issues**
> As a junior Linux administrator, I want to use `systemctl`, `journalctl`, and log files to identify service failures, so that I can restore application functionality.

**3.4 – Troubleshoot Hardware Issues**
> As a junior Linux administrator, I want to use `dmesg`, `lspci`, and `lsblk` to diagnose issues with physical devices or virtual machines, so that I can identify failing hardware or misconfigured virtualization layers.

---

### 🌐 Domain 4.0 – Automation and Scripting

**4.1 – Scripting Basics**
> As a junior Linux administrator, I want to write and execute simple Bash scripts using conditionals and loops, so that I can automate repetitive tasks and reduce manual effort.

**4.2 – Version Control**
> As a junior Linux administrator, I want to use Git to clone, commit, and push changes to a remote repository, so that I can manage configuration changes and collaborate with other admins.

**4.3 – Orchestration and Infrastructure as Code**
> As a junior Linux administrator, I want to read and modify YAML/JSON configuration files and understand container manifests, so that I can integrate with DevOps workflows or automation pipelines.

**4.4 – Cloud and Virtualization Concepts**
> As a junior Linux administrator, I want to understand basic cloud storage concepts, virtualization layers, and container runtimes, so that I can support hybrid environments and hosted systems.

---

## 📌 Next Steps

- [ ] Add LPIC-1 user stories
- [ ] Add LFCS user stories
- [ ] Add RHCSA user stories
