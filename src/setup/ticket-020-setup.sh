#!/bin/bash
echo "[+] Setting up environment for ticket-020..."

# Create a background monitoring task
sleep 600 &
MONITOR_PID=$!

# Create the runtime directory if it doesn't exist
mkdir -p /var/run/sysadmin-sim/ticket-020

# Store the PID for checking
echo "$MONITOR_PID" > /var/run/sysadmin-sim/ticket-020/pid.txt
echo "[+] Monitoring process 'monitortask' started with PID $MONITOR_PID."

