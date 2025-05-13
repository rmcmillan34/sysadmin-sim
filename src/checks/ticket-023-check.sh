#!/bin/bash
echo "[+] Checking solution for ticket-023..."

FLAG=$(yq e '.flag' /root/tickets/ticket-023.yaml)
EXPECTED=$(cat /var/run/sysadmin-sim/ticket-023/log_count.txt)

if [[ -f /home/sysadmin/log-count.txt ]]; then
    ACTUAL=$(cat /home/sysadmin/log-count.txt | tr -d '[:space:]')
    if [[ "$ACTUAL" == "$EXPECTED" ]]; then
        echo "[✓] Correct number of .log files found: $ACTUAL"
        echo "$FLAG"
        exit 0
    else
        echo "[✗] Incorrect count. Expected: $EXPECTED, Got: $ACTUAL"
        exit 1
    fi
else
    echo "[✗] Missing output file /home/sysadmin/log-count.txt"
    exit 1
fi

