#!/bin/bash
set -e  # Exit immediately if any command fails

USERNAME="sysadmin"
USER_HOME="/home/${USERNAME}"

echo "[+] Creating user: $USERNAME"

# Check if the user already exists to avoid duplicate creation
if id "$USERNAME" >/dev/null 2>&1; then
    echo "[i] User $USERNAME already exists"
else
    # If adduser is available (Debian/Ubuntu), use it
    if command -v adduser >/dev/null 2>&1; then
        echo "[+] Using adduser to create user"
        # --disabled-password: no login password required
        # --gecos "": bypass full name prompt
        # --home: set home directory
        # --shell: set default shell
        adduser --disabled-password --gecos "" --home "$USER_HOME" --shell /bin/bash "$USERNAME"

    # Otherwise, fallback to useradd (used on most distros)
    elif command -v useradd >/dev/null 2>&1; then
        echo "[+] Using useradd to create user"
        # -m: create home directory
        # -d: set home path
        # -s: set default shell
        useradd -m -d "$USER_HOME" -s /bin/bash "$USERNAME"
    
    else
        echo "[!] No compatible user creation tool found"
        exit 1
    fi
fi

# Ensure home directory exists and is owned by the user
mkdir -p "$USER_HOME"
chown "$USERNAME:$USERNAME" "$USER_HOME" || true

echo "[+] Disabling sudo and restricting escalation tools"

# If sudo exists, disable it for the sysadmin user
if command -v sudo >/dev/null 2>&1; then
    echo "$USERNAME ALL=(ALL) NOPASSWD: /bin/false" > /etc/sudoers.d/disable-sudo
    chmod 440 /etc/sudoers.d/disable-sudo
fi

# Restrict common privilege escalation tools if present
# This is optional and non-fatal if these binaries are not present
for binary in /usr/bin/su /usr/bin/pkexec; do
    if [ -f "$binary" ]; then
        chmod 750 "$binary" || true
        chown root:root "$binary" || true
    fi
done

# Lock the root account to prevent login (optional hardening)
if command -v passwd >/dev/null 2>&1; then
    passwd -l root || true
fi

echo "[+] Setup complete for user: $USERNAME"
