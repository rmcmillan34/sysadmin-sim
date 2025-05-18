
#!/bin/bash
set -e

# --- Path setup ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TICKETS_DIR="${SCRIPT_DIR}/../tickets"
SETUP_DIR="${SCRIPT_DIR}/../setup"
CHECKS_DIR="${SCRIPT_DIR}/../checks"

# --- Determine next ticket number ---
max_num=$(find "$TICKETS_DIR" -type f -name 'ticket-*.yaml' \
            | grep -oE 'ticket-[0-9]+' \
            | cut -d- -f2 \
            | sort -n \
            | tail -1)
if [[ -z "$max_num" ]]; then
    next_num=1
else
    next_num=$((10#$max_num + 1))
fi
TICKET_NUM=$(printf "%03d" "$next_num")
TICKET_NAME="ticket-${TICKET_NUM}"
FLAG_HASH=$(echo "${TICKET_NAME}.yaml" | md5sum | cut -d' ' -f1)

# --- File paths for new ticket ---
YAML_FILE="${TICKETS_DIR}/${TICKET_NAME}.yaml"
SETUP_SCRIPT="${SETUP_DIR}/${TICKET_NAME}-setup.sh"
STRIKEDOWN_SCRIPT="${SETUP_DIR}/${TICKET_NAME}-strikedown.sh"
CHECK_SCRIPT="${CHECKS_DIR}/${TICKET_NAME}-check.sh"

# --- Safely resolve path for printing ---
safe_resolve() {
    local DIR="$(cd "$(dirname "$1")" && pwd)"
    local FILE="$(basename "$1")"
    echo "$DIR/$FILE"
}

# --- Existence check ---
if [[ -f "$YAML_FILE" ]]; then
    echo "[✗] Ticket already exists: $(safe_resolve "$YAML_FILE")"
    echo "    Refusing to overwrite existing ticket."
    exit 1
fi

# --- Output planned creation ---
echo "[+] Creating files for: $TICKET_NAME"
echo "[i] Ticket YAML:        $(safe_resolve "$YAML_FILE")"
echo "[i] Setup script:       $(safe_resolve "$SETUP_SCRIPT")"
echo "[i] Strikedown script:  $(safe_resolve "$STRIKEDOWN_SCRIPT")"
echo "[i] Check script:       $(safe_resolve "$CHECK_SCRIPT")"
echo "[✓] Flag hash:          LINUX{${FLAG_HASH}}"

# --- File creation logic ---
touch "$YAML_FILE"
touch "$SETUP_SCRIPT"      && chmod +x "$SETUP_SCRIPT"
touch "$STRIKEDOWN_SCRIPT" && chmod +x "$STRIKEDOWN_SCRIPT"
touch "$CHECK_SCRIPT"      && chmod +x "$CHECK_SCRIPT"

