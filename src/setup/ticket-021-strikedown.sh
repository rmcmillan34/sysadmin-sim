#!/bin/bash

echo "[+] Cleaning up environment for ticket-021..."

# Kill high CPU process if still running
if [[ -f /var/run/sysadmin-sim/ticket-021/pid.txt ]]; then
    PID=$(cat /var/run/sysadmin-sim/ticket-021/pid.txt)
    if ps -p "$PID" > /dev/null 2>&1; then
        kill "$PID"
        echo "[+] Process $PID terminated."
    fi
    rm -f /var/run/sysadmin-sim/ticket-021/pid.txt
fi

rmdir /var/run/sysadmin-sim/ticket-021 2>/dev/null || true

