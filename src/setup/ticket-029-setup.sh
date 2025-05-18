#!/bin/bash
echo "[+] Setting up environment for ticket-029..."

BASE="/var/tmp/webcache"
mkdir -p "$BASE"/{images,tmp,db,session,cache}

# Populate with random file sizes

## images = largest (50MB)
dd if=/dev/urandom of="$BASE/images/big.img" bs=1M count=50 status=none

## tmp = 5MB
dd if=/dev/urandom of="$BASE/tmp/tmpfile.bin" bs=1M count=5 status=none

## db = 20MB
dd if=/dev/urandom of="$BASE/db/index.db" bs=1M count=20 status=none

## session = 1MB
dd if=/dev/urandom of="$BASE/session/session1" bs=1M count=1 status=none

## cache = 10MB split
dd if=/dev/urandom of="$BASE/cache/cache1" bs=1M count=5 status=none
dd if=/dev/urandom of="$BASE/cache/cache2" bs=1M count=5 status=none

echo "[✓] Webcache structure created."

