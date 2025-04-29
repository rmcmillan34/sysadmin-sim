#!/bin/bash

ANSWER_FILE="/home/sysadmin/ticket-011-answer.txt"

if [[ -f "$ANSWER_FILE" ]]; then
    ANSWER=$(tr -d '[:space:]' < "$ANSWER_FILE")
    if [[ "$ANSWER" == "C" ]]; then
        echo "Correct! Flag: LINUX{45c48cce2e2d7fbdea1afc51c7c6ad26}"
        exit 0
    else
        echo "Incorrect answer."
        exit 1
    fi
else
    echo "Answer file not found."
    exit 1
fi

