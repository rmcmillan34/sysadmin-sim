#!/bin/bash
echo "[+] Setting up environment for ticket-024..."

# Clean/create working directory
MARKER_DIR="/home/sysadmin/markers"
mkdir -p "$MARKER_DIR"
rm -f "$MARKER_DIR/backup.marker"

# Capture the system time for validation window
mkdir -p /var/run/sysadmin-sim/ticket-024
date +%s > /var/run/sysadmin-sim/ticket-024/launch_time.txt

