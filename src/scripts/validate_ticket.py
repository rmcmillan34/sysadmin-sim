# scripts/validate_ticket.py

import yaml
import sys
import os
import stat

REQUIRED_FIELDS = [
    "id",
    "title",
    "difficulty",
    "description",
    "objectives",
    "question_type",
    "check_script",
]
VALID_DIFFICULTIES = {"easy", "medium", "hard", "expert"}

def is_executable(filepath):
    return os.access(filepath, os.X_OK)

def validate_ticket(ticket, ticket_path):
    errors = []

    for field in REQUIRED_FIELDS:
        if field not in ticket:
            errors.append(f"Missing required field: {field}")

    if "difficulty" in ticket and ticket["difficulty"] not in VALID_DIFFICULTIES:
        errors.append(f"Invalid difficulty: {ticket['difficulty']}")

    if not isinstance(ticket.get("objectives", []), list):
        errors.append("Objectives should be a list")

    if "hints" in ticket and not isinstance(ticket["hints"], list):
        errors.append("Hints should be a list")

    if "tags" in ticket and not isinstance(ticket["tags"], list):
        errors.append("Tags should be a list")

    if "timeout" in ticket and not isinstance(ticket["timeout"], int):
        errors.append("Timeout must be an integer")

    # Check for check_script file
    if "check_script" in ticket:
        script_path = ticket["check_script"]
        full_path = os.path.join(os.path.dirname(ticket_path), "..", script_path)
        full_path = os.path.abspath(full_path)

        if not os.path.isfile(full_path):
            errors.append(f"Checker script not found: {script_path} (resolved to: {full_path})")
        elif not is_executable(full_path):
            errors.append(f"Checker script is not executable: {script_path}")

    return errors

def main():
    if len(sys.argv) != 2:
        print("Usage: python scripts/validate_ticket.py <ticket.yaml>")
        sys.exit(1)

    path = sys.argv[1]
    if not os.path.exists(path):
        print(f"File not found: {path}")
        sys.exit(1)

    with open(path) as f:
        try:
            ticket = yaml.safe_load(f)
        except yaml.YAMLError as e:
            print(f"YAML Error: {e}")
            sys.exit(1)

    errors = validate_ticket(ticket, path)

    if errors:
        print("❌ Validation errors:")
        for err in errors:
            print(f"  - {err}")
        sys.exit(1)
    else:
        print("✅ Ticket is valid!")

if __name__ == "__main__":
    main()
