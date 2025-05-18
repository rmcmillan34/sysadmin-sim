#!/bin/bash
echo "[+] Checking solution for ticket-026..."

FLAG=$(yq e '.flag' /src/tickets/ticket-026.yaml)
EXPECTED=$(stat -c "%Y" /etc/sysadmin-sim/test.conf)

if [[ ! -f /home/sysadmin/stat-result.txt ]]; then
    echo "[✗] stat-result.txt was not created."
    exit 1
fi

USER_TIMESTAMP=$(cat /home/sysadmin/stat-result.txt | xargs -I{} date -d "{}" +%s 2>/dev/null)

if [[ "$USER_TIMESTAMP" == "$EXPECTED" ]]; then
    echo "[✓] Correct timestamp extracted."
    echo "$FLAG"
    exit 0
else
    echo "[✗] Timestamp mismatch. Got: $USER_TIMESTAMP, Expected: $EXPECTED"
    exit 1
fi

