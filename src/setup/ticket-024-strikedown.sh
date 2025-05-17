#!/bin/bash
echo "[+] Cleaning up environment for ticket-024..."

rm -rf /home/sysadmin/markers
rm -f /var/run/sysadmin-sim/ticket-024/launch_time.txt
rmdir /var/run/sysadmin-sim/ticket-024 2>/dev/null || true

