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

## 🧪 LFCS (2024)

### 🧩 Domain 1 – Operations Deployment

**1.1 – Configure kernel parameters, persistent and non-persistent**  
> As a Linux administrator, I want to modify kernel parameters using `sysctl` and update `/etc/sysctl.conf` to persist them, so that I can tune system performance and behavior across reboots.

**1.2 – Diagnose, identify, manage, and troubleshoot processes and services**  
> As a Linux administrator, I want to use commands like `ps`, `top`, `systemctl`, and `kill` to investigate high CPU usage or stopped services, so that I can restore normal operation on production systems.

**1.3 – Manage or schedule jobs for executing commands**  
> As a Linux administrator, I want to create scheduled jobs using `crontab` and monitor one-time jobs with `at`, so that I can automate routine tasks without user intervention.

**1.4 – Search for, install, validate, and maintain software packages or repositories**  
> As a Linux administrator, I want to use `apt`, `dnf`, or `zypper` to install packages, verify versions, and manage repositories, so that I can maintain software availability and system integrity.

**1.5 – Recover from hardware, operating system, or filesystem failures**  
> As a Linux administrator, I want to access recovery shells and check logs or file system health with `fsck`, so that I can troubleshoot boot issues or fix corrupted partitions.

**1.6 – Manage Virtual Machines (libvirt)**  
> As a Linux administrator, I want to use `virsh` to start, stop, and inspect virtual machines, so that I can manage virtualization environments using libvirt.

**1.7 – Configure container engines, create and manage containers**  
> As a Linux administrator, I want to use `podman` or `docker` to run, inspect, and remove containers, so that I can deploy isolated applications on the system.

**1.8 – Create and enforce MAC using SELinux**  
> As a Linux administrator, I want to verify SELinux modes and use `semanage` or `chcon` to resolve denials, so that I can enforce fine-grained access controls for services and files.

---

### 🌐 Domain 2 – Networking

**2.1 – Configure IPv4 and IPv6 networking and hostname resolution**  
> As a Linux administrator, I want to assign IP addresses and DNS resolvers using `ip`, `nmcli`, or `/etc/hosts`, so that I can ensure stable network communication.

**2.2 – Set and synchronize system time using time servers**  
> As a Linux administrator, I want to configure `chronyd` or `systemd-timesyncd` to synchronize with NTP servers, so that the system clock remains accurate across all nodes.

**2.3 – Monitor and troubleshoot networking**  
> As a Linux administrator, I want to use `ping`, `traceroute`, `ss`, and `tcpdump` to investigate connection issues, so that I can diagnose and resolve network downtime quickly.

**2.4 – Configure the OpenSSH server and client**  
> As a Linux administrator, I want to configure `sshd_config` and manage SSH keys for secure access, so that users and admins can connect to servers remotely with confidence.

**2.5 – Configure packet filtering, port redirection, and NAT**  
> As a Linux administrator, I want to use `iptables` or `firewalld` to filter ports and redirect traffic, so that I can enforce network security and route services properly.

**2.6 – Configure static routing**  
> As a Linux administrator, I want to define persistent static routes using `ip route add` or `/etc/sysconfig/network-scripts`, so that I can control outbound traffic paths for internal routing.

**2.7 – Configure bridge and bonding devices**  
> As a Linux administrator, I want to configure network bridges and link aggregation using `nmcli` or `ifcfg` files, so that I can increase throughput or provide failover networking.

**2.8 – Implement reverse proxies and load balancers**  
> As a Linux administrator, I want to configure `nginx` or `haproxy` as a reverse proxy or load balancer, so that I can distribute traffic across multiple backend services.

---

### 💾 Domain 3 – Storage

**3.1 – Configure and manage LVM storage**  
> As a Linux administrator, I want to create physical volumes, volume groups, and logical volumes using `pvcreate`, `vgcreate`, and `lvcreate`, so that I can manage flexible and resizable storage pools.

**3.2 – Manage and configure the virtual file system**  
> As a Linux administrator, I want to view and understand virtual files like `/proc/meminfo` and `/sys`, so that I can analyze kernel and hardware state in real-time.

**3.3 – Create, manage, and troubleshoot filesystems**  
> As a Linux administrator, I want to use `mkfs`, `mount`, and `fsck` to create and repair filesystems, so that the server remains stable and data is accessible.

**3.4 – Use remote filesystems and network block devices**  
> As a Linux administrator, I want to mount NFS shares and configure iSCSI targets, so that I can attach remote storage to the system reliably.

**3.5 – Configure and manage swap space**  
> As a Linux administrator, I want to create swap files or partitions and activate them with `mkswap` and `swapon`, so that I can provide additional memory resources under pressure.

**3.6 – Configure filesystem automounters**  
> As a Linux administrator, I want to use `autofs` to automatically mount network shares on demand, so that I can improve boot times and reduce dependency issues.

**3.7 – Monitor storage performance**  
> As a Linux administrator, I want to use `iostat`, `iotop`, and `df` to identify storage bottlenecks, so that I can prevent IO-related service degradation.

---

### 🔧 Domain 4 – Essential Commands

**4.1 – Basic Git Operations**  
> As a Linux administrator, I want to use `git` to clone, stage, commit, and push configuration files to a shared repository, so that changes are version-controlled and backed up.

**4.2 – Create, configure, and troubleshoot services**  
> As a Linux administrator, I want to manage services using `systemctl`, create unit files, and review logs using `journalctl`, so that I can control daemons and resolve issues.

**4.3 – Monitor and troubleshoot system performance and services**  
> As a Linux administrator, I want to use tools like `top`, `htop`, `free`, and `uptime` to assess system load and identify resource hogs, so that I can maintain a responsive environment.

**4.4 – Determine application and service specific constraints**  
> As a Linux administrator, I want to inspect logs, permissions, and config files to identify why a service is misbehaving or unable to bind to ports, so that I can unblock service failures quickly.

**4.5 – Troubleshoot diskspace issues**  
> As a Linux administrator, I want to use `du` and `df` to find out what directories are consuming space and take corrective action, so that the system does not run out of disk capacity.

**4.6 – Work with SSL certificates**  
> As a Linux administrator, I want to create, view, and install SSL certificates using `openssl` and web server configuration, so that I can secure HTTPS services on Linux.

---

### 👥 Domain 5 – Users and Groups

**5.1 – Create and manage local user and group accounts**  
> As a Linux administrator, I want to use `useradd`, `groupadd`, and `passwd` to create and manage user credentials and access control, so that I can onboard and offboard users securely.

**5.2 – Manage personal and system-wide environment profiles**  
> As a Linux administrator, I want to configure environment variables using `.bashrc`, `.bash_profile`, and `/etc/environment`, so that login shells behave consistently for users.

**5.3 – Configure user resource limits**  
> As a Linux administrator, I want to use `/etc/security/limits.conf` to restrict how much CPU, memory, or processes a user can consume, so that I can protect the system from abuse or runaway apps.

**5.4 – Configure and manage ACLs**  
> As a Linux administrator, I want to apply Access Control Lists using `setfacl` and `getfacl`, so that I can assign permissions beyond standard user/group/other models.

**5.5 – Configure the system to use LDAP user and group accounts**  
> As a Linux administrator, I want to configure `sssd` and `nslcd` with an LDAP server and test authentication, so that users can log in using central identity management.

---



---

## 📌 Next Steps

- [ ] Add LPIC-1 user stories
- [ ] Add LPIC-2 user stories
- [ ] Add RHCSA user stories
