#!/bin/bash

OUTPUT_FILE="/home/sysadmin/ps_full_output.txt"

# Check if the output file exists
if [[ ! -f "$OUTPUT_FILE" ]]; then
    echo "Output file not found."
    exit 1
fi

# Check if the output includes typical fields from ps aux (UID, PID, %CPU, %MEM)
if grep -qiE 'pid|%cpu|%mem|user' "$OUTPUT_FILE"; then
    echo "Correct! Flag: LINUX{92eb5ffee6ae2fec3ad71c777531578f}"
    exit 0
else
    echo "Output file does not contain expected process details."
    exit 1
fi

