#!/bin/bash
echo "[+] Cleaning up environment for ticket-020..."

# Terminate the monitoring process if it exists
if [[ -f /var/run/sysadmin-sim/ticket-020/pid.txt ]]; then
    PID=$(cat /var/run/sysadmin-sim/ticket-020/pid.txt)
    if ps -p "$PID" > /dev/null 2>&1; then
        kill "$PID"
        echo "[+] Monitoring process $PID terminated."
    fi
    rm -f /var/run/sysadmin-sim/ticket-020/pid.txt
fi

# Clean up the runtime directory
rmdir /var/run/sysadmin-sim/ticket-020 2>/dev/null || true

