import os
import sys
import types

# Add src/scripts to import path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "src", "scripts")))

# Provide a lightweight yaml stub if PyYAML is unavailable
if 'yaml' not in sys.modules:
    yaml_stub = types.ModuleType('yaml')
    yaml_stub.safe_load = lambda *_args, **_kwargs: {}
    yaml_stub.YAMLError = Exception
    sys.modules['yaml'] = yaml_stub

from validate_ticket import validate_ticket


def test_valid_ticket():
    ticket = {
        "id": "ticket-001",
        "title": "Sample ticket",
        "difficulty": "easy",
        "description": "A simple description",
        "objectives": ["demo"],
    }
    errors = validate_ticket(ticket, "ticket.yml")
    assert errors == []


def test_missing_required_field():
    ticket = {
        "id": "ticket-002",
        # title missing
        "difficulty": "easy",
        "description": "desc",
        "objectives": [],
    }
    errors = validate_ticket(ticket, "ticket.yml")
    assert "Missing required field: title" in errors


def test_invalid_difficulty():
    ticket = {
        "id": "ticket-003",
        "title": "Invalid diff",
        "difficulty": "impossible",
        "description": "desc",
        "objectives": [],
    }
    errors = validate_ticket(ticket, "ticket.yml")
    assert "Invalid difficulty: impossible" in errors
