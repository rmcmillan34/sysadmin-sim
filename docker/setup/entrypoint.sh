#!/bin/bash

set -e

echo "[+] Entrypoint started..."
echo "[+] Attempting to launch SSH daemons..."

# Start sysadmin SSHD
if [[ -f /etc/ssh/sshd_sysadmin.conf ]]; then
  echo "[+] Found sshd_sysadmin.conf, starting SSH on port 2222..."
  /usr/sbin/sshd -f /etc/ssh/sshd_sysadmin.conf
else
  echo "[!] sshd_sysadmin.conf not found!"
fi

# Start root/admin SSHD
if [[ -f /etc/ssh/sshd_rootadmin.conf ]]; then
  echo "[+] Found sshd_rootadmin.conf, starting SSH on port 2223..."
  /usr/sbin/sshd -f /etc/ssh/sshd_rootadmin.conf
else
  echo "[!] sshd_rootadmin.conf not found!"
fi

# Final confirmation
echo "[✓] SSH setup complete — container is staying alive."

#####################################################################
#####       SysAdmin Simulator Configuration Script             #####
#####################################################################

CONFIG_DIR="$HOME/.config/sysadmin-simulator"
CONFIG_FILE="$CONFIG_DIR/config.yaml"
CONFIG_SCRIPT="/src/scripts/sysadmin-sim-config.sh"

# Check if the config directory exists, if not create it
if [[ ! -d "$CONFIG_DIR" ]]; then
    echo "[+] Creating config directory at $CONFIG_DIR"
    mkdir -p "$CONFIG_DIR"
fi

# Create the config file and script
touch "$CONFIG_FILE"
touch "$CONFIG_SCRIPT"

# Check if the config file exists on login
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "[+] Initial setup: Configuring SysAdmin Simulator."
    bash "$CONFIG_SCRIPT"
fi

# Set up alias for configurator future access
if ! grep -q "alias sysadmin-sim" "$HOME/.bashrc"; then
    echo "alias sysadmin-sim='bash $CONFIG_SCRIPT'" >> "$HOME/.bashrc"
    echo "[+] Added sysadmin-sim alias to .bashrc"
fi

#if ! grep -q "alias sysadmin-sim" "$HOME/.zshrc"; then
#    echo "alias sysadmin-sim='bash $CONFIG_SCRIPT'" >> "$HOME/.zshrc"
#    echo "[+] Added sysadmin-sim alias to .zshrc"
#fi

# Refresh the shell to apply alias immediately
source "$HOME/.bashrc" 2>/dev/null

echo "[+] Welcome to SysAdmin Simulator!"
echo "[+] Type 'sysadmin-sim' to configure your experience."

# Keep container running
tail -f /dev/null
