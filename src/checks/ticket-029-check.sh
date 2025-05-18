#!/bin/bash
echo "[+] Checking solution for ticket-029..."

FLAG=$(yq e '.flag' /src/tickets/ticket-029.yaml)
ANSWER_FILE="/home/sysadmin/largest-dir.txt"

EXPECTED_NAME="images"

# 1. Check file exists
if [[ ! -f "$ANSWER_FILE" ]]; then
    echo "[✗] Output file not found: $ANSWER_FILE"
    exit 1
fi

# 2. Validate content
ANSWER=$(cat "$ANSWER_FILE" | xargs)

if [[ "$ANSWER" != "$EXPECTED_NAME" ]]; then
    echo "[✗] Incorrect output."
    echo "  Expected: $EXPECTED_NAME"
    echo "  Got:      $ANSWER"
    exit 1
fi

# 3. Check if du was recently used
HISTORY_LINES=$(tail -n 20 /home/sysadmin/.bash_history 2>/dev/null)

if ! echo "$HISTORY_LINES" | grep -q '\bdu\b'; then
    echo "[✗] 'du' command not detected in the last 20 shell history entries."
    echo "    Be sure you're using 'du' to calculate disk usage."
    exit 1
fi

# Success!
echo "[✓] Correct directory identified using 'du'."
echo "$FLAG"
exit 0

