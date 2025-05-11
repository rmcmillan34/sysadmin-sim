#!/bin/bash
echo "[+] Cleaning up environment for ticket-019..."

# Terminate the hanging process if it exists
if [[ -f /var/run/sysadmin-sim/ticket-019/pid.txt ]]; then
    PID=$(cat /var/run/sysadmin-sim/ticket-019/pid.txt)
    if ps -p "$PID" > /dev/null 2>&1; then
        kill "$PID"
        echo "[+] Process $PID terminated."
    fi
    rm -f /var/run/sysadmin-sim/ticket-019/pid.txt
fi

# Clean up the runtime directory
rmdir /var/run/sysadmin-sim/ticket-019 2>/dev/null || true

