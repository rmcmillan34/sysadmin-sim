#!/bin/bash
echo "[+] Checking solution for ticket-024..."

FLAG=$(yq e '.flag' /root/tickets/ticket-024.yaml)
MARKER="/home/sysadmin/markers/backup.marker"
REFERENCE_TIME=$(cat /var/run/sysadmin-sim/ticket-024/launch_time.txt)

if [[ ! -f "$MARKER" ]]; then
    echo "[✗] File $MARKER not found."
    exit 1
fi

FILE_TIMESTAMP=$(stat -c %Y "$MARKER")
NOW=$(date +%s)
MAX_DIFF=300

if (( FILE_TIMESTAMP >= REFERENCE_TIME && FILE_TIMESTAMP <= NOW && (NOW - FILE_TIMESTAMP) <= MAX_DIFF )); then
    echo "[✓] File created with a valid recent timestamp."
    echo "$FLAG"
    exit 0
else
    echo "[✗] File timestamp is outside acceptable window."
    exit 1
fi

