#!/bin/bash

# Setup script for Ticket 017 - Create a dummy sleep process
echo "[+] Setting up environment for Ticket 017..."

# Start a background sleep process
sleep 300 &
SLEEP_PID=$!

# Record the PID to a known file for checker to validate
mkdir -p /opt/ticket-017/
echo "$SLEEP_PID" > /opt/ticket-017/expected-pid.txt

echo "[+] Sleep process started successfully.  
exit 0

