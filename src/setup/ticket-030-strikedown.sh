#!/bin/bash
echo "[+] Cleaning up environment for ticket-030..."

# Remove audit log file and directory
rm -f /var/log/audit/audit.log
rmdir --ignore-fail-on-non-empty /var/log/audit

# Remove the user’s output
rm -f /home/sysadmin/audit-perms.txt

echo "[✓] ticket-030 cleanup complete."

