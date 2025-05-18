#!/bin/bash
echo "[+] Setting up environment for ticket-028..."

ARCHIVE_DIR="/var/log/archive"
mkdir -p "$ARCHIVE_DIR/deep/inner"
mkdir -p "$ARCHIVE_DIR/deep/new"

# Target files (older than 7 days + >5MB)
dd if=/dev/zero of="$ARCHIVE_DIR/log-old1.log" bs=1M count=6 status=none
dd if=/dev/zero of="$ARCHIVE_DIR/deep/inner/log-old2.log" bs=1M count=10 status=none
touch -d "10 days ago" "$ARCHIVE_DIR/log-old1.log"
touch -d "15 days ago" "$ARCHIVE_DIR/deep/inner/log-old2.log"

# Noise files
dd if=/dev/zero of="$ARCHIVE_DIR/log-new-small.log" bs=1M count=2 status=none
touch -d "2 days ago" "$ARCHIVE_DIR/log-new-small.log"

dd if=/dev/zero of="$ARCHIVE_DIR/deep/inner/log-old-small.log" bs=1M count=2 status=none
touch -d "10 days ago" "$ARCHIVE_DIR/deep/inner/log-old-small.log"

dd if=/dev/zero of="$ARCHIVE_DIR/deep/new/log-new-big.log" bs=1M count=10 status=none
touch -d "1 day ago" "$ARCHIVE_DIR/deep/new/log-new-big.log"

echo "[+] Log files created — ready to test find filters."

