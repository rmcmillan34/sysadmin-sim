#!/bin/bash
echo "[+] Checking solution for ticket-022..."

FLAG=$(yq e '.flag' /root/tickets/ticket-022.yaml)
EXPECTED=$(cat /var/run/sysadmin-sim/ticket-022/error_count.txt)

if [[ -f /home/sysadmin/error-count.txt ]]; then
    ACTUAL=$(cat /home/sysadmin/error-count.txt | tr -d '[:space:]')
    if [[ "$ACTUAL" == "$EXPECTED" ]]; then
        echo "[✓] Correct count of ERROR lines: $ACTUAL"
        echo "$FLAG"
        exit 0
    else
        echo "[✗] Incorrect error count. Expected: $EXPECTED, Got: $ACTUAL"
        exit 1
    fi
else
    echo "[✗] File /home/sysadmin/error-count.txt not found."
    exit 1
fi

