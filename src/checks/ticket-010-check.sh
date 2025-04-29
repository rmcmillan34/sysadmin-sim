#!/bin/bash

ANSWER_FILE="/tmp/ticket-010-answer.txt"

if [[ -f "$ANSWER_FILE" ]]; then
    ANSWER=$(tr -d '[:space:]' < "$ANSWER_FILE")
    if [[ "$ANSWER" == "B" ]]; then
        echo "Correct! Flag: LINUX{9d5ed678fe57bcca610140957afab571}"
        exit 0
    else
        echo "Incorrect answer."
        exit 1
    fi
else
    echo "Answer file not found."
    exit 1
fi

