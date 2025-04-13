#!/bin/sh
set -e

echo "[+] Starting SSH services..."

# Start sysadmin SSHD (port 2222)
if [ -f /etc/ssh/sshd_sysadmin.conf ]; then
  /usr/sbin/sshd -f /etc/ssh/sshd_sysadmin.conf
else
  echo "[!] Missing sysadmin SSH config"
fi

# Start root/admin SSHD (port 2223)
if [ -f /etc/ssh/sshd_rootadmin.conf ]; then
  /usr/sbin/sshd -f /etc/ssh/sshd_rootadmin.conf
else
  echo "[!] Missing root SSH config"
fi

# Keep the container alive (tail preferred over sleep for debug visibility)
tail -f /dev/null
