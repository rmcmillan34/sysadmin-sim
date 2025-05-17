#!/bin/bash
echo "[+] Setting up environment for ticket-025..."

TARGET_DIR="/var/sysadmin-sim/mystery"
RUNTIME_DIR="/var/run/sysadmin-sim/ticket-025"
mkdir -p "$TARGET_DIR" "$RUNTIME_DIR"
rm -f "$TARGET_DIR"/*

# File name pool (no extensions)
FILENAMES=(alpha beta gamma delta epsilon omega zeta xi tau upsilon phi chi psi rho sigma theta lambda)

# Choose a random index for the shell script
SCRIPT_INDEX=$((RANDOM % ${#FILENAMES[@]}))
SCRIPT_FILE="${FILENAMES[$SCRIPT_INDEX]}"

# Create files
for i in "${!FILENAMES[@]}"; do
    FILE="$TARGET_DIR/${FILENAMES[$i]}"
    if [[ "$i" == "$SCRIPT_INDEX" ]]; then
        echo -e "#!/bin/bash\necho 'You found the script!'" > "$FILE"
        chmod +x "$FILE"
    else
        case $((RANDOM % 4)) in
            0) echo "Plain text data $(date)" > "$FILE" ;;
            1) head -c 128 /dev/urandom > "$FILE" ;;
            2) echo -e "%PDF-1.4\n%EOF" > "$FILE" ;;
            3) printf "\x7fELF" > "$FILE" ;;  # ELF magic header
        esac
    fi
done

# Save the correct answer
echo "$SCRIPT_FILE" > "$RUNTIME_DIR/answer.txt"
echo "[+] Shell script stored as: $SCRIPT_FILE"

