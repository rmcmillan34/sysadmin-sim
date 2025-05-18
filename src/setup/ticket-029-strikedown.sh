#!/bin/bash
echo "[+] Cleaning up environment for ticket-029..."

# Remove all generated files and subdirs
rm -f /var/tmp/webcache/images/big.img
rm -f /var/tmp/webcache/tmp/tmpfile.bin
rm -f /var/tmp/webcache/db/index.db
rm -f /var/tmp/webcache/session/session1
rm -f /var/tmp/webcache/cache/cache1
rm -f /var/tmp/webcache/cache/cache2

# Remove subdirectories (ignore errors if non-empty)
rmdir --ignore-fail-on-non-empty \
    /var/tmp/webcache/images \
    /var/tmp/webcache/tmp \
    /var/tmp/webcache/db \
    /var/tmp/webcache/session \
    /var/tmp/webcache/cache \
    /var/tmp/webcache

# Remove output file
rm -f /home/sysadmin/largest-dir.txt

