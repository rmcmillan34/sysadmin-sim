#!/bin/bash
echo "[+] Cleaning up environment for ticket-022..."

rm -f /var/log/sysadmin-sim/failure.log
rm -f /var/run/sysadmin-sim/ticket-022/error_count.txt
rmdir /var/run/sysadmin-sim/ticket-022 2>/dev/null || true

