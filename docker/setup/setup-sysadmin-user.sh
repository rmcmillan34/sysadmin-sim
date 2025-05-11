#!/bin/bash
set -e  # Exit on any error

USERNAME="sysadmin"
USER_HOME="/home/${USERNAME}"

echo "[+] Creating user: $USERNAME"

# Check if the user already exists
if id "$USERNAME" >/dev/null 2>&1; then
    echo "[i] User $USERNAME already exists"
else
    # Detect Debian-based distros
    if [ -f /etc/debian_version ]; then
        echo "[+] Detected Debian-based system — using adduser"
        adduser --disabled-password --gecos "" --home "$USER_HOME" --shell /bin/bash "$USERNAME"
    else
        echo "[+] Using useradd for non-Debian system"
        useradd -m -d "$USER_HOME" -s /bin/bash "$USERNAME"
    fi
fi

echo "[+] Create sysadmin HOME directory and set permissions"
# Ensure home directory exists and is owned by the user
mkdir -p "$USER_HOME"
chown -R "$USERNAME:$USERNAME" "$USER_HOME" || true

# Ensure .bashrc exists
if [[ ! -f "$USER_HOME/.bashrc" ]]; then
    touch "$USER_HOME/.bashrc"
fi

# Add alias for the sysadmin user
if ! grep -q "alias sysadmin-sim" "$USER_HOME/.bashrc"; then
    echo "alias sysadmin-sim='sudo /bin/sysadmin-sim/sysadmin-sim-config.sh'" >> "$USER_HOME/.bashrc"
    echo "[+] Added sysadmin-sim alias to $USER_HOME/.bashrc"
fi

# Add the sysadmin user to sudoers securely
if ! grep -q "$USERNAME" /etc/sudoers.d/sysadmin-sim 2>/dev/null; then
    echo "$USERNAME ALL=(ALL) NOPASSWD: /bin/sysadmin-sim/sysadmin-sim-config.sh" > /etc/sudoers.d/sysadmin-sim
    chmod 440 /etc/sudoers.d/sysadmin-sim
    echo "[+] Configured sudo access for $USERNAME"
fi

echo "[+] Disabling sudo and restricting privilege escalation tools"
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

echo "[+] Setup complete for user: $USERNAME"

