#!/bin/bash
echo "[+] Checking solution for ticket-025..."

FLAG=$(yq e '.flag' /root/tickets/ticket-025.yaml)
EXPECTED=$(cat /var/run/sysadmin-sim/ticket-025/answer.txt)

if [[ -f /home/sysadmin/shellscript.txt ]]; then
    ACTUAL=$(cat /home/sysadmin/shellscript.txt | tr -d '[:space:]')
    if [[ "$ACTUAL" == "$EXPECTED" ]]; then
        echo "[✓] Correct! The shell script was identified."
        echo "$FLAG"
        exit 0
    else
        echo "[✗] Incorrect file name. Expected: $EXPECTED, Got: $ACTUAL"
        exit 1
    fi
else
    echo "[✗] Output file /home/sysadmin/shellscript.txt not found."
    exit 1
fi

