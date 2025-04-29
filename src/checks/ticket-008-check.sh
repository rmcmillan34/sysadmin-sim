#!/bin/bash

ANSWER_FILE="/tmp/ticket-008-answer.txt"

if [[ -f "$ANSWER_FILE" ]]; then
    ANSWER=$(tr -d '[:space:]' < "$ANSWER_FILE")
    if [[ "$ANSWER" == "B" ]]; then
        echo "Correct! Flag: LINUX{9ae0ea9e3c9c6e1b9b6252c8395efdc1}"
        exit 0
    else
        echo "Incorrect answer."
        exit 1
    fi
else
    echo "Answer file not found."
    exit 1
fi

