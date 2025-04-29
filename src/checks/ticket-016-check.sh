#!/bin/bash

OUTPUT_FILE="/home/sysadmin/uptime_load_output.txt"

# Check if the output file exists
if [[ ! -f "$OUTPUT_FILE" ]]; then
    echo "Output file not found."
    exit 1
fi

# Check if output contains load averages (three numbers typically at end of line)
if grep -qE 'load average' "$OUTPUT_FILE"; then
    echo "Correct! Flag: LINUX{b6d767d2f8ed5d21a44b0e5886680cb9}"
    exit 0
else
    echo "Output file does not contain expected load average information."
    exit 1
fi

