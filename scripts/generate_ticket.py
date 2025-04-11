# scripts/generate_ticket.py

import yaml
import os

def prompt_list(prompt):
    print(f"{prompt} (Enter blank line to finish)")
    items = []
    while True:
        line = input("- ")
        if not line:
            break
        items.append(line)
    return items

def main():
    print("🎫 Ticket Generator\n------------------")

    ticket = {
        "id": input("Ticket ID (e.g., ticket-001): ").strip(),
        "title": input("Title: ").strip(),
        "difficulty": input("Difficulty (easy, medium, hard, expert): ").strip().lower(),
        "description": input("Description (single line or paragraph): ").strip(),
        "objectives": prompt_list("Objectives"),
    }

    if input("Add hints? (y/n): ").lower() == 'y':
        ticket["hints"] = prompt_list("Hints")

    if input("Add timeout? (y/n): ").lower() == 'y':
        ticket["timeout"] = int(input("Timeout in seconds: ").strip())

    if input("Add flag? (y/n): ").lower() == 'y':
        ticket["flag"] = input("Flag (e.g., lnx{fix_done}): ").strip()

    if input("Add tags? (y/n): ").lower() == 'y':
        ticket["tags"] = prompt_list("Tags")

    if input("Add check_script? (y/n): ").lower() == 'y':
        ticket["check_script"] = input("Checker script path (e.g., checks/ticket-001-check.sh): ").strip()

    out_dir = "tickets"
    os.makedirs(out_dir, exist_ok=True)
    out_path = os.path.join(out_dir, f"{ticket['id']}.yaml")

    with open(out_path, 'w') as f:
        yaml.dump(ticket, f, sort_keys=False)

    print(f"\n✅ Ticket saved to: {out_path}")

if __name__ == "__main__":
    main()
