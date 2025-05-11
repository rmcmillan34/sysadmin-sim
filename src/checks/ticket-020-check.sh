#!/bin/bash
echo "[+] Checking solution for ticket-020..."

# Load the flag from the ticket YAML
FLAG=$(yq e '.flag' /root/tickets/ticket-020.yaml)

# Check if the PID file exists
if [[ -f /home/sysadmin/monitortask.pid ]]; then
    USER_PID=$(cat /home/sysadmin/monitortask.pid)
    # Verify that the PID matches the running monitortask
    if ps -p "$USER_PID" | grep -q "sleep"; then
        echo "[✓] Correct! The PID of 'monitortask' is $USER_PID."
        echo "$FLAG"
        exit 0
    else
        echo "[✗] The PID in the file does not match any running process."
        exit 1
    fi
else
    echo "[✗] PID file not found in /home/sysadmin."
    exit 1
fi

