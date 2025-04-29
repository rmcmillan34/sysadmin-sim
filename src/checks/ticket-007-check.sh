#!/bin/bash

ANSWER_FILE="/home/sysadmin/ticket-007-answer.txt"

if [[ -f "$ANSWER_FILE" ]]; then
    ANSWER=$(tr -d '[:space:]' < "$ANSWER_FILE")
    if [[ "$ANSWER" == "A" ]]; then
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

