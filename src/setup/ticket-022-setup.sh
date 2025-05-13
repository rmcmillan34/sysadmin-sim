#!/bin/bash
echo "[+] Setting up environment for ticket-022..."

# Directories and paths
LOG_DIR="/var/log/sysadmin-sim"
LOG_FILE="$LOG_DIR/failure.log"
RUNTIME_DIR="/var/run/sysadmin-sim/ticket-022"

mkdir -p "$LOG_DIR"
mkdir -p "$RUNTIME_DIR"

# Total lines and random error count
TOTAL_LINES=$((RANDOM % 50 + 50))  # 50–99 lines
ERROR_COUNT=$((RANDOM % 4 + 3))    # 3–6 error lines

# Track how many errors we’ve inserted
error_inserted=0

# Create log content
> "$LOG_FILE"
for i in $(seq 1 "$TOTAL_LINES"); do
    # Randomly insert ERROR lines
    if [[ $error_inserted -lt $ERROR_COUNT && $((RANDOM % 10)) -lt 2 ]]; then
        echo "[ERROR] Service X failed at $(date +%T)." >> "$LOG_FILE"
        error_inserted=$((error_inserted + 1))
    else
        echo "[INFO] Log line $i generated at $(date +%T)." >> "$LOG_FILE"
    fi
done

# If we didn't insert enough errors, append them at the end
while [[ $error_inserted -lt $ERROR_COUNT ]]; do
    echo "[ERROR] Service Y failed late at $(date +%T)." >> "$LOG_FILE"
    error_inserted=$((error_inserted + 1))
done

# Save actual count for check script
echo "$error_inserted" > "$RUNTIME_DIR/error_count.txt"

