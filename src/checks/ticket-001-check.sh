#!/bin/bash

# Check if the answer file exists and contains only the correct answer
ANSWER_FILE="/tmp/ticket-001-answer.txt"

if [[ -f "$ANSWER_FILE" ]]; then
    ANSWER=$(tr -d '[:space:]' < "$ANSWER_FILE")
    if [[ "$ANSWER" == "C" ]]; then
        echo "Correct! Flag: LINUX{e4da3b7fbbce2345d7772b0674a318d5}"
        exit 0
    else
        echo "Incorrect answer."
        exit 1
    fi
else
    echo "Answer file not found."
    exit 1
fi
