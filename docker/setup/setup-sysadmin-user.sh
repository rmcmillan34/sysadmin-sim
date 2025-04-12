#!/bin/bash
set -e  # Exit on any error

USERNAME="sysadmin"
USER_HOME="/home/${USERNAME}"

echo "[+] Creating user: $USERNAME"

# Check if the user already exists
if id "$USERNAME" >/dev/null 2>&1; then
    echo "[i] User $USERNAME already exists"
else
    # Detect Debian-based distros (has /etc/debian_version)
    if [ -f /etc/debian_version ]; then
        echo "[+] Detected Debian-based system — using adduser"
        # --disabled-password: user can't log in via password
        # --gecos "": skip interactive prompts
        # --home: specify home directory
        # --shell: specify default shell
        adduser --disabled-password --gecos "" --home "$USER_HOME" --shell /bin/bash "$USERNAME"
    else
        echo "[+] Using useradd for non-Debian system"
        # -m: create home
        # -d: set home path
        # -s: set shell
        useradd -m -d "$USER_HOME" -s /bin/bash "$USERNAME"
    fi
fi

# Ensure home directory exists and is owned by the user
mkdir -p "$USER_HOME"
chown -R "$USERNAME" "$USER_HOME" || true

echo "[+] Disabling sudo and restricting privilege escalation tools"

# Create /etc/sudoers.d if missing and restrict sudo usage for sysadmin
if command -v sudo >/dev/null 2>&1; then
    mkdir -p /etc/sudoers.d
    echo "$USERNAME ALL=(ALL) NOPASSWD: /bin/false" > /etc/sudoers.d/disable-sudo
    chmod 440 /etc/sudoers.d/disable-sudo
fi

# Restrict access to tools like su and pkexec if they exist
for binary in /usr/bin/su /usr/bin/pkexec; do
    if [ -f "$binary" ]; then
        chmod 750 "$binary" || true
        chown root:root "$binary" || true
    fi
done

# Lock root account if passwd and shadow file are available
if command -v passwd >/dev/null 2>&1 && [ -f /etc/shadow ]; then
    passwd -l root || true
fi

echo "[+] Setup complete for user: $USERNAME"
