#!/bin/bash
set -e

USERNAME="sysadmin"
USER_HOME="/home/${USERNAME}"

echo "[+] Creating user: $USERNAME"

# Create user with fallback for busybox distros
if command -v adduser >/dev/null 2>&1 && ! id "$USERNAME" >/dev/null 2>&1; then
    adduser -D -s /bin/bash "$USERNAME" || true
elif command -v useradd >/dev/null 2>&1 && ! id "$USERNAME" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "$USERNAME" || true
fi

# Ensure home directory exists and is owned
mkdir -p "$USER_HOME"
chown "$USERNAME:$USERNAME" "$USER_HOME"

echo "[+] Disabling sudo and restricting privilege escalation tools"

# Disable sudo if present
if command -v sudo >/dev/null 2>&1; then
    echo "$USERNAME ALL=(ALL) NOPASSWD: /bin/false" > /etc/sudoers.d/disable-sudo
    chmod 440 /etc/sudoers.d/disable-sudo
fi

# Optionally restrict binaries like su and pkexec
for binary in /usr/bin/su /usr/bin/pkexec; do
    if [ -f "$binary" ]; then
        chmod 750 "$binary" || true
        chown root:root "$binary" || true
    fi
done

# Lock root password (still accessible to scripts, not users)
passwd -l root || true

echo "[+] Setup complete for user: $USERNAME"
