#!/bin/bash
echo "[+] Setting up environment for ticket-031..."

# Clean any previous attempt just in case
rm -f /home/sysadmin/umask-check.txt
rm -f /home/sysadmin/testfile-umask

# Leave the environment untouched — the point is to test default shell umask
echo "[✓] Environment prepared. Ready to observe default umask behavior."

