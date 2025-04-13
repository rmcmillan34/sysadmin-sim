#!/bin/bash
set -e

echo "[+] Installing and configuring OpenSSH..."

# Install OpenSSH (distro-agnostic)
if command -v apt-get >/dev/null 2>&1; then
    apt-get update && apt-get install -y openssh-server
elif command -v dnf >/dev/null 2>&1; then
    dnf install -y openssh-server
elif command -v apk >/dev/null 2>&1; then
    apk add --no-cache openssh
else
    echo "[!] Could not determine package manager for OpenSSH install"
    exit 1
fi

# Ensure runtime directory exists
mkdir -p /var/run/sshd

# Copy SSH configurations
cp /tmp/sshd_sysadmin.conf /etc/ssh/sshd_sysadmin.conf
cp /tmp/sshd_rootadmin.conf /etc/ssh/sshd_rootadmin.conf

# Set default passwords (MVP only — do not use in production)
echo "sysadmin:sysadmin" | chpasswd
echo "root:adminroot" | chpasswd

# Ensure banner file exists (placeholder for now)
cp /tmp/login-banner.player.txt /etc/login-banner.player
cp /tmp/login-banner.admin.txt /etc/login-banner.admin

echo "[+] OpenSSH setup complete — daemons will be started at runtime."
