#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/sysadmin-sim"
CONFIG_FILE="$CONFIG_DIR/config.yaml"
DEFAULT_CONFIG="$SCRIPT_DIR/../config/default.yaml"

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# If no config exists, seed with defaults
if [[ ! -f "$CONFIG_FILE" ]]; then
    if [[ -f "$DEFAULT_CONFIG" ]]; then
        cp "$DEFAULT_CONFIG" "$CONFIG_FILE"
    else
        cat <<EOF > "$CONFIG_FILE"
game_mode: Exam
exam_target: Linux+
timer_display: prompt
difficulty: easy
EOF
    fi
fi

function show_menu() {
    echo "======================================="
    echo "    🛠️  SysAdmin Simulator Config       "
    echo "======================================="
    echo "1. Set Game Mode (Exam, Random, Continuous)"
    echo "2. Set Exam Target (Linux+, LPIC-1, LFCS, RHCSA)"
    echo "3. Set Timer Display (prompt, background, both, none)"
    echo "4. Set Difficulty (easy, medium, hard, expert)"
    echo "5. View Current Settings"
    echo "6. Reset to Default"
    echo "0. Exit"
}

function set_option() {
    local key=$1
    local value=$2
    yq -i ".$key = \"$value\"" "$CONFIG_FILE"
    echo "[+] Updated: $key set to $value"
}

function configure() {
    while true; do
        show_menu
        read -p "Select an option [0-6]: " choice
        case $choice in
            1) 
                read -p "Enter game mode (Exam, Random, Continuous): " mode
                set_option "game_mode" "$mode"
                ;;
            2) 
                read -p "Enter exam target (Linux+, LPIC-1, LFCS, RHCSA): " exam
                set_option "exam_target" "$exam"
                ;;
            3) 
                read -p "Enter timer display (prompt, background, both, none): " timer
                set_option "timer_display" "$timer"
                ;;
            4) 
                read -p "Enter difficulty (easy, medium, hard, expert): " difficulty
                set_option "difficulty" "$difficulty"
                ;;
            5) 
                echo "Current Configuration:"
                cat "$CONFIG_FILE"
                ;;
            6)
                if [[ -f "$DEFAULT_CONFIG" ]]; then
                    cp "$DEFAULT_CONFIG" "$CONFIG_FILE"
                else
                    cat <<EOF > "$CONFIG_FILE"
game_mode: Exam
exam_target: Linux+
timer_display: prompt
difficulty: easy
EOF
                fi
                echo "[+] Reset to default configuration."
                ;;
            0) 
                echo "Exiting configuration."
                break
                ;;
            *) 
                echo "Invalid choice. Please try again."
                ;;
        esac
    done
}

# Run the configuration menu
configure

