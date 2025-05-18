#!/bin/bash
echo "[+] Setting up environment for ticket-030..."

TARGET="/var/log/audit"
FILE="$TARGET/audit.log"

# Create directory and insecure file
mkdir -p "$TARGET"
echo "SECURITY: insecure permissions on this file" > "$FILE"
chmod 777 "$FILE"

echo "[✓] Created audit.log with world-writable permissions (777)."

