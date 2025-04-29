#!/bin/bash

OUTPUT_FILE="/tmp/top_cpu_output.txt"

# Check if the output file exists
if [[ ! -f "$OUTPUT_FILE" ]]; then
    echo "Output file not found."
    exit 1
fi

# Check if the file contains references to CPU-related metrics
if grep -qiE 'cpu|%cpu' "$OUTPUT_FILE"; then
    echo "Correct! Flag: LINUX{0cc175b9c0f1b6a831c399e269772661}"
    exit 0
else
    echo "Output file does not show CPU usage information."
    exit 1
fi

