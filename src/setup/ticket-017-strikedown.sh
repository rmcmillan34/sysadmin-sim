#!/bin/bash

# Strikedown script for Ticket 017 - Cleanup after ticket
echo "[+] Cleaning up environment for Ticket 017..."

# Kill any leftover sleep process
if [[ -f /opt/ticket-017/expected-pid.txt ]]; then
    PID=$(cat /opt/ticket-017/expected-pid.txt)
    if ps -p "$PID" &> /dev/null; then
        kill "$PID" &> /dev/null
        echo "[+] Sleep process $PID terminated."
    fi
    rm -f /opt/ticket-017/expected-pid.txt
fi

echo "[+] Ticket 017 environment strikedown successful."

exit 0

