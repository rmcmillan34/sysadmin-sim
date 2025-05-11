#!/bin/bash
echo "[+] Checking solution for ticket-019..."

# Load the flag from the ticket YAML
FLAG=$(yq e '.flag' /root/tickets/ticket-019.yaml)

# Get the PID of the hangtask
if [[ -f /var/run/sysadmin-sim/ticket-019/pid.txt ]]; then
    PID=$(cat /var/run/sysadmin-sim/ticket-019/pid.txt)
    # Check if the process is still running
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "[✗] The process with PID $PID is still running. Expected: not running."
        exit 1
    else
        echo "[✓] The process has been successfully terminated."
        echo "$FLAG"
        exit 0
    fi
else
    echo "[✗] Process ID file not found."
    exit 1
fi

