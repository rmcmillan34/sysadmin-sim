#!/bin/bash
echo "[+] Checking solution for ticket-027..."

FLAG=$(yq e '.flag' /src/tickets/ticket-027.yaml)
EXPECTED="/var/log/archive/backups/passwd-shadow.bak"
ANSWER_FILE="/home/sysadmin/passwd-backup.txt"

if [[ ! -f "$ANSWER_FILE" ]]; then
    echo "[✗] Answer file not found at: $ANSWER_FILE"
    exit 1
fi

USER_PATH=$(cat "$ANSWER_FILE")

# Must match expected and must NOT be a symlink
if [[ "$USER_PATH" == "$EXPECTED" ]] && [[ ! -L "$USER_PATH" ]]; then
    echo "[✓] Correct file path located."
    echo "$FLAG"
    exit 0
else
    echo "[✗] Incorrect path."
    echo "  Expected: $EXPECTED"
    echo "  Got:      $USER_PATH"
    [[ -L "$USER_PATH" ]] && echo "  (✗) It’s a symlink!"
    exit 1
fi

