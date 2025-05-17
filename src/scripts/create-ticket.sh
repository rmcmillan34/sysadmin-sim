#!/bin/bash
set -e

# --- Define paths ---
TICKETS_DIR="../tickets"
CHECKS_DIR="../checks"
SETUP_DIR="../setup"
# --- Detect latest ticket number ---
LATEST=$(find "$TICKETS_DIR" -maxdepth 1 -name 'ticket-*.yaml' \
    | grep -oE 'ticket-[0-9]+' \
    | cut -d'-' -f2 \
    | sort -n | tail -n1)

if [ -z "$LATEST" ]; then
    NEXT_NUM=1
else
    NEXT_NUM=$((LATEST + 1))
fi

# --- Format ticket ID ---
TICKET_NUM=$(printf "%03d" "$NEXT_NUM")
TICKET_NAME="ticket-${TICKET_NUM}"
FLAG_HASH=$(echo "${TICKET_NAME}.yaml" | md5sum | cut -d' ' -f1)

# --- Define full file paths ---
YAML_FILE="${TICKETS_DIR}/${TICKET_NAME}.yaml"
SETUP_SCRIPT="${SETUP_DIR}/${TICKET_NAME}-setup.sh"
CHECK_SCRIPT="${CHECKS_DIR}/${TICKET_NAME}-check.sh"
STRIKEDOWN_SCRIPT="${CHECKS_DIR}/${TICKET_NAME}-strikedown.sh"

# --- Create files ---
echo "[+] Creating ticket files for ${TICKET_NAME}..."
#touch "$YAML_FILE"
echo "[✓] Created: $YAML_FILE"

#touch "$SETUP_SCRIPT"
#chmod +x "$SETUP_SCRIPT"
echo "[✓] Created: $SETUP_SCRIPT"

#touch "$CHECK_SCRIPT"
#chmod +x "$CHECK_SCRIPT"
echo "[✓] Created: $CHECK_SCRIPT"

#touch "$STRIKEDOWN_SCRIPT"
#chmod +x "$STRIKEDOWN_SCRIPT"
echo "[✓] Created: $STRIKEDOWN_SCRIPT"

# --- Output generated flag ---
echo "[✓] Flag hash for YAML: LINUX{${FLAG_HASH}}"

