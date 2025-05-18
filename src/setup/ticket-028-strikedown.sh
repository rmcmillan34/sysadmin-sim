#!/bin/bash
echo "[+] Cleaning up environment for ticket-028..."

# Remove files
rm -f /var/log/archive/log-old1.log
rm -f /var/log/archive/deep/inner/log-old2.log
rm -f /var/log/archive/log-new-small.log
rm -f /var/log/archive/deep/inner/log-old-small.log
rm -f /var/log/archive/deep/new/log-new-big.log
rm -f /home/sysadmin/old-large-logs.txt

# Clean nested dirs (ignore errors if not empty)
rmdir --ignore-fail-on-non-empty /var/log/archive/deep/new
rmdir --ignore-fail-on-non-empty /var/log/archive/deep/inner
rmdir --ignore-fail-on-non-empty /var/log/archive/deep
rmdir --ignore-fail-on-non-empty /var/log/archive

