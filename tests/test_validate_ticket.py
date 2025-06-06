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


def test_valid_ticket(tmp_path):
    script = tmp_path / "dummy.sh"
    script.write_text("#!/bin/sh\nexit 0\n")
    script.chmod(0o755)

    ticket = {
        "id": "ticket-001",
        "title": "Sample ticket",
        "difficulty": "easy",
        "description": "A simple description",
        "objectives": ["demo"],
        "question_type": "scripting",
        "check_script": script.name,
    }
    ticket_path = tmp_path / "tickets" / "ticket.yml"
    ticket_path.parent.mkdir()
    errors = validate_ticket(ticket, str(ticket_path))
    assert errors == []


def test_missing_required_field(tmp_path):
    script = tmp_path / "dummy.sh"
    script.write_text("#!/bin/sh\n")
    script.chmod(0o755)

    ticket = {
        "id": "ticket-002",
        # title missing
        "difficulty": "easy",
        "description": "desc",
        "objectives": [],
        "question_type": "command_demo",
        "check_script": script.name,
    }
    ticket_path = tmp_path / "tickets" / "ticket.yml"
    ticket_path.parent.mkdir()
    errors = validate_ticket(ticket, str(ticket_path))
    assert "Missing required field: title" in errors


def test_invalid_difficulty(tmp_path):
    script = tmp_path / "dummy.sh"
    script.write_text("#!/bin/sh\n")
    script.chmod(0o755)

    ticket = {
        "id": "ticket-003",
        "title": "Invalid diff",
        "difficulty": "impossible",
        "description": "desc",
        "objectives": [],
        "question_type": "config",
        "check_script": script.name,
    }
    ticket_path = tmp_path / "tickets" / "ticket.yml"
    ticket_path.parent.mkdir()
    errors = validate_ticket(ticket, str(ticket_path))
    assert "Invalid difficulty: impossible" in errors


def test_missing_question_type(tmp_path):
    script = tmp_path / "dummy.sh"
    script.write_text("#!/bin/sh\n")
    script.chmod(0o755)

    ticket = {
        "id": "ticket-004",
        "title": "Missing qtype",
        "difficulty": "easy",
        "description": "desc",
        "objectives": [],
        "check_script": script.name,
    }
    ticket_path = tmp_path / "tickets" / "ticket.yml"
    ticket_path.parent.mkdir()
    errors = validate_ticket(ticket, str(ticket_path))
    assert "Missing required field: question_type" in errors


def test_missing_check_script(tmp_path):
    ticket = {
        "id": "ticket-005",
        "title": "Missing check",
        "difficulty": "easy",
        "description": "desc",
        "objectives": [],
        "question_type": "command_demo",
    }
    ticket_path = tmp_path / "tickets" / "ticket.yml"
    ticket_path.parent.mkdir()
    errors = validate_ticket(ticket, str(ticket_path))
    assert "Missing required field: check_script" in errors
