#!/bin/bash
echo "[+] Setting up environment for ticket-026..."

CONF_FILE="/etc/sysadmin-sim/test.conf"
mkdir -p /etc/sysadmin-sim
echo "configuration=enabled" > "$CONF_FILE"

# Touch to simulate last modification
touch -d "1 minute ago" "$CONF_FILE"

