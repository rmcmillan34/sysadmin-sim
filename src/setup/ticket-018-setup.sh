#!/bin/bash
echo "[+] Setting up environment for ticket-018..."

# Create runtime directory for PID storage
mkdir -p /var/run/sysadmin-sim/ticket-018

# Start a slow process with a low priority
nice -n 15 sleep 300 &
SLEEP_PID=$!

# Record the PID for checking
echo "$SLEEP_PID" > /var/run/sysadmin-sim/ticket-018/pid.txt
echo "[+] Slow process started with PID $SLEEP_PID and nice value 15."


