# scripts/validate_ticket.py

import yaml
import sys
import os

REQUIRED_FIELDS = ["id", "title", "difficulty", "description", "objectives"]
VALID_DIFFICULTIES = {"easy", "medium", "hard", "expert"}

def validate_ticket(ticket):
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

    return errors

def main():
    if len(sys.argv) != 2:
        print("Usage: python validate_ticket.py <ticket.yaml>")
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

    errors = validate_ticket(ticket)

    if errors:
        print("❌ Validation errors:")
        for err in errors:
            print(f"  - {err}")
        sys.exit(1)
    else:
        print("✅ Ticket is valid!")

if __name__ == "__main__":
    main()
