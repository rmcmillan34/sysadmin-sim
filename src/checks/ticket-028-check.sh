#!/bin/bash
echo "[+] Checking solution for ticket-028..."

FLAG=$(yq e '.flag' /src/tickets/ticket-028.yaml)
OUTPUT="/home/sysadmin/old-large-logs.txt"
TARGET1="/var/log/archive/log-old1.log"
TARGET2="/var/log/archive/deep/inner/log-old2.log"

# 1. Check output file exists
if [[ ! -f "$OUTPUT" ]]; then
    echo "[✗] Output file not found: $OUTPUT"
    exit 1
fi

# 2. Check for required matches
if ! grep -q "$TARGET1" "$OUTPUT" || ! grep -q "$TARGET2" "$OUTPUT"; then
    echo "[✗] Output file does not contain all correct paths."
    exit 1
fi

# 3. Ensure no incorrect results are present
BAD_MATCHES=$(grep -E 'log-new|small' "$OUTPUT")
if [[ -n "$BAD_MATCHES" ]]; then
    echo "[✗] Output file contains incorrect entries:"
    echo "$BAD_MATCHES"
    exit 1
fi

# 4. Confirm 'find' was used recently
RECENT_HISTORY=$(tail -n 20 /home/sysadmin/.bash_history 2>/dev/null)
if ! echo "$RECENT_HISTORY" | grep -q '\bfind\b'; then
    echo "[✗] 'find' command not detected in the last 20 shell history entries."
    echo "    Be sure you're using find to solve this task."
    exit 1
fi

# Success
echo "[✓] Correct files located using find."
echo "$FLAG"
exit 0

