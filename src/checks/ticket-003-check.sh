#!/bin/bash

ANSWER_FILE="/tmp/ticket-002-answer.txt"

if [[ -f "$ANSWER_FILE" ]]; then
    ANSWER=$(tr -d '[:space:]' < "$ANSWER_FILE")
    if [[ "$ANSWER" == "A" ]]; then
        echo "Correct! Flag: LINUX{7fc56270e7a70fa81a5935b72eacbe29}"
        exit 0
    else
        echo "Incorrect answer."
        exit 1
    fi
else
    echo "Answer file not found."
    exit 1
fi
