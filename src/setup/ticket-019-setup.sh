#!/bin/bash
echo "[+] Setting up environment for ticket-019..."

# Create runtime directory for PID storage
mkdir -p /var/run/sysadmin-sim/ticket-019

# Start a hanging process
sleep 600 &
HANG_PID=$!

# Record the PID for checking
echo "$HANG_PID" > /var/run/sysadmin-sim/ticket-019/pid.txt
echo "[+] Hanging process started with PID $HANG_PID."

