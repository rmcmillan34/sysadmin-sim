#!/bin/bash
echo "[+] Cleaning up environment for ticket-027..."

rm -f /var/log/archive/backups/passwd-shadow.bak
rm -f /var/log/archive/backups/passwords.bak
rm -f /var/log/archive/passwd-copy.bak
rm -f /var/tmp/passwd.d/passwd1.tmp
rm -f /var/tmp/.passwd-hidden.bak
rm -f /opt/data/shadow/shadow-passwd.bak
rm -f /home/sysadmin/passwd-backup.txt

# Clean empty directories
rmdir --ignore-fail-on-non-empty /var/log/archive/backups /var/tmp/passwd.d /opt/data/shadow /var/log/archive /opt/data /var/tmp

