#!/bin/bash
echo "[+] Checking solution for ticket-030..."

FLAG=$(yq e '.flag' /src/tickets/ticket-030.yaml)
FILE="/var/log/audit/audit.log"
ANSWER_FILE="/home/sysadmin/audit-perms.txt"

# 1. Check that the file exists
if [[ ! -f "$FILE" ]]; then
    echo "[✗] Missing file: $FILE"
    exit 1
fi

# 2. Extract and check actual file permissions
PERMS=$(stat -c "%A" "$FILE")
EXPECTED_PERMS="rw-r--r--"

if [[ "$PERMS" != "$EXPECTED_PERMS" ]]; then
    echo "[✗] Incorrect permissions."
    echo "  Expected: $EXPECTED_PERMS"
    echo "  Got:      $PERMS"
    exit 1
fi

# 3. Check result file content
if [[ ! -f "$ANSWER_FILE" ]]; then
    echo "[✗] Missing answer file: $ANSWER_FILE"
    exit 1
fi

USER_ANSWER=$(cat "$ANSWER_FILE" | xargs)
if [[ "$USER_ANSWER" != "$EXPECTED_PERMS" ]]; then
    echo "[✗] Answer file has incorrect content."
    echo "  Expected: $EXPECTED_PERMS"
    echo "  Got:      $USER_ANSWER"
    exit 1
fi

# 4. Confirm 'chmod' was recently used
if ! tail -n 20 /home/sysadmin/.bash_history 2>/dev/null | grep -q '\bchmod\b'; then
    echo "[✗] 'chmod' command not found in recent shell history."
    exit 1
fi

# Success!
echo "[✓] Permissions updated and validated."
echo "$FLAG"
exit 0

