#!/bin/bash
echo "[+] Cleaning up environment for ticket-025..."

rm -rf /var/sysadmin-sim/mystery
rm -f /var/run/sysadmin-sim/ticket-025/answer.txt
rmdir /var/run/sysadmin-sim/ticket-025 2>/dev/null || true
