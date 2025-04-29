#!/bin/bash

OUTPUT_FILE="/tmp/free_memory_output.txt"

# Check if the output file exists
if [[ ! -f "$OUTPUT_FILE" ]]; then
    echo "Output file not found."
    exit 1
fi

# Check if output contains memory fields
if grep -qiE 'mem|total|used|free' "$OUTPUT_FILE"; then
    echo "Correct! Flag: LINUX{58c10d8d25c869239d1d39fb8bcbac2b}"
    exit 0
else
    echo "Output file does not contain expected memory usage information."
    exit 1
fi

