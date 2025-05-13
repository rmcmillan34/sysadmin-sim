#!/bin/bash
echo "[+] Setting up environment for ticket-023..."

TARGET_DIR="/var/sysadmin-sim/logs"
RUNTIME_DIR="/var/run/sysadmin-sim/ticket-023"

mkdir -p "$TARGET_DIR"
mkdir -p "$RUNTIME_DIR"

# Clear any old data
rm -rf "$TARGET_DIR"/*
LOG_COUNT=0

# Generate 30–50 files in random subdirs, with some ending in .log
TOTAL_FILES=$((RANDOM % 21 + 30))  # 30–50 total
for i in $(seq 1 $TOTAL_FILES); do
    SUBDIR="$TARGET_DIR/sub$((RANDOM % 5))"
    mkdir -p "$SUBDIR"

    if (( RANDOM % 3 == 0 )); then
        touch "$SUBDIR/file$i.log"
        LOG_COUNT=$((LOG_COUNT + 1))
    else
        touch "$SUBDIR/file$i.tmp"
    fi
done

# Save actual log count
echo "$LOG_COUNT" > "$RUNTIME_DIR/log_count.txt"
echo "[+] Created $LOG_COUNT .log files among $TOTAL_FILES total."

