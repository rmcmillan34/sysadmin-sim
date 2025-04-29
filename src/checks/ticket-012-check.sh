#!/bin/bash

ANSWER_FILE="/tmp/ticket-012-answer.txt"

if [[ -f "$ANSWER_FILE" ]]; then
    ANSWER=$(tr -d '[:space:]' < "$ANSWER_FILE")
    if [[ "$ANSWER" == "B" ]]; then
        echo "Correct! Flag: LINUX{b6d767d2f8ed5d21a44b0e5886680cb9}"
        exit 0
    else
        echo "Incorrect answer."
        exit 1
    fi
else
    echo "Answer file not found."
    exit 1
fi

