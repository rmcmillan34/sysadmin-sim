#!/bin/bash

ANSWER_FILE="/tmp/ticket-004-answer.txt"

if [[ -f "$ANSWER_FILE" ]]; then
    ANSWER=$(tr -d '[:space:]' < "$ANSWER_FILE")
    if [[ "$ANSWER" == "A" ]]; then
        echo "Correct! Flag: LINUX{c9f0f895fb98ab9159f51fd0297e236d}"
        exit 0
    else
        echo "Incorrect answer."
        exit 1
    fi
else
    echo "Answer file not found."
    exit 1
fi
