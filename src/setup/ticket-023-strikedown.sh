#!/bin/bash
echo "[+] Cleaning up environment for ticket-023..."

rm -rf /var/sysadmin-sim/logs
rm -f /var/run/sysadmin-sim/ticket-023/log_count.txt
rmdir /var/run/sysadmin-sim/ticket-023 2>/dev/null || true

