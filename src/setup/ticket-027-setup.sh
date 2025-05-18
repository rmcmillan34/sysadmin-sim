#!/bin/bash
echo "[+] Setting up environment for ticket-027..."

# Create a realistic nested file tree
mkdir -p /var/log/archive/backups
mkdir -p /var/tmp/passwd.d
mkdir -p /opt/data/shadow

# The real target (only this one is correct)
REAL_FILE="/var/log/archive/backups/passwd-shadow.bak"
echo "backup-passwords" > "$REAL_FILE"

# Noise files
echo "temp data" > /var/log/archive/backups/passwords.bak
echo "wrong file" > /var/tmp/passwd.d/passwd1.tmp
echo "shadowed" > /opt/data/shadow/shadow-passwd.bak

# Add a symlink pointing to the correct file, to mislead `locate`
ln -s "$REAL_FILE" /var/log/archive/passwd-copy.bak

# Also add a hidden dotfile with a similar name
echo "decoy" > /var/tmp/.passwd-hidden.bak

echo "[+] Environment created."

