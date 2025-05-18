#!/bin/bash
echo "[+] Checking solution for ticket-031..."

FLAG=$(yq e '.flag' /src/tickets/ticket-031.yaml)
ANSWER_FILE="/home/sysadmin/umask-check.txt"

# Ensure result file exists
if [[ ! -f "$ANSWER_FILE" ]]; then
    echo "[✗] Answer file missing: $ANSWER_FILE"
    exit 1
fi

# Parse the result
read -r UMASK_ENTRY PERM_ENTRY < "$ANSWER_FILE"

# Validate umask format (e.g., 0022 or 022)
if [[ ! "$UMASK_ENTRY" =~ ^0?[0-7]{3}$ ]]; then
    echo "[✗] Invalid umask format: '$UMASK_ENTRY'"
    exit 1
fi

# Validate permission format (symbolic, e.g., rw-r--r--)
if [[ ! "$PERM_ENTRY" =~ ^[-rwx]{9}$ ]]; then
    echo "[✗] Invalid permission string: '$PERM_ENTRY'"
    exit 1
fi

# Check if 'umask' was used in the last 20 shell commands
if ! tail -n 20 /home/sysadmin/.bash_history 2>/dev/null | grep -q '\bumask\b'; then
    echo "[✗] 'umask' command not detected in recent shell history."
    exit 1
fi

# If all checks passed
echo "[✓] Umask value and permission string look valid."
echo "$FLAG"
exit 0

