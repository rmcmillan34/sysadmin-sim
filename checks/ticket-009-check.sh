#!/bin/bash

ANSWER_FILE="/home/sysadmin/ticket-009-answer.txt"

if [[ -f "$ANSWER_FILE" ]]; then
    ANSWER=$(tr -d '[:space:]' < "$ANSWER_FILE")
    if [[ "$ANSWER" == "A" ]]; then
        echo "Correct! Flag: LINUX{c81e728d9d4c2f636f067f89cc14862c}"
        exit 0
    else
        echo "Incorrect answer."
        exit 1
    fi
else
    echo "Answer file not found."
    exit 1
fi

