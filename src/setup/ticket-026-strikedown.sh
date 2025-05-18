#!/bin/bash
echo "[+] Cleaning up environment for ticket-026..."

rm -f /etc/sysadmin-sim/test.conf
rmdir --ignore-fail-on-non-empty /etc/sysadmin-sim
rm -f /home/sysadmin/stat-result.txt

