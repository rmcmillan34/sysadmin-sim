#!/bin/bash
echo "[+] Checking solution for ticket-018..."

# Load the flag from the ticket YAML
FLAG=$(yq e '.flag' /root/tickets/ticket-018.yaml)

# Get the PID of the slowtask
if [[ -f /var/run/sysadmin-sim/ticket-018/pid.txt ]]; then
    PID=$(cat /var/run/sysadmin-sim/ticket-018/pid.txt)
    # Check if the process has the correct nice value
    CURRENT_NICE=$(ps -o nice= -p "$PID" 2>/dev/null)
    if [[ "$CURRENT_NICE" == "5" ]]; then
        echo "[✓] The nice value has been correctly set to 5."
        echo "$FLAG"
        exit 0
    else
        echo "[✗] The nice value is incorrect. Expected: 5, Got: $CURRENT_NICE"
        exit 1
    fi
else
    echo "[✗] Process ID file not found."
    exit 1
fi

