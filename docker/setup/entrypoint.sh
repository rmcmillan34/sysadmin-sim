#!/bin/sh
set -e

echo "[+] Entrypoint started..."
echo "[+] Attempting to launch SSH daemons..."

# Start sysadmin SSHD
if [ -f /etc/ssh/sshd_sysadmin.conf ]; then
  echo "[+] Found sshd_sysadmin.conf, starting SSH on port 2222..."
  /usr/sbin/sshd -f /etc/ssh/sshd_sysadmin.conf
else
  echo "[!] sshd_sysadmin.conf not found!"
fi

# Start root/admin SSHD
if [ -f /etc/ssh/sshd_rootadmin.conf ]; then
  echo "[+] Found sshd_rootadmin.conf, starting SSH on port 2223..."
  /usr/sbin/sshd -f /etc/ssh/sshd_rootadmin.conf
else
  echo "[!] sshd_rootadmin.conf not found!"
fi

# Final confirmation
echo "[✓] SSH setup complete — container is staying alive."

# Keep container running
tail -f /dev/null
