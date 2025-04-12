# 📦 Exam Bundle Specification

This document defines the structure and runtime behavior of exam bundles in the SysAdmin Simulator. An exam bundle is a curated or auto-generated collection of tickets designed to simulate a certification-style terminal assessment experience.

---

## 🎯 Purpose

Exam bundles allow users to:
- Practice cert-style challenges in a time-boxed environment
- Receive a balanced distribution of topics aligned to exam domains
- Launch randomized containers that vary per run while maintaining coverage

---

## 🧱 Bundle Structure

An exam bundle consists of the following components:

- `exam.yaml`: Defines the exam metadata, ticket list, and structure
- `tickets/`: Contains the ticket YAML files selected for this exam
- `checks/`: Contains the checker scripts associated with the selected tickets
- `setup/`: (optional) Contains `setup.sh` files or assets per ticket

### Folder layout

```bash
/exam-bundles/linuxplus-basic/
├── exam.yaml
├── tickets/
│   ├── ticket-001.yaml
│   ├── ticket-004.yaml
│   └── ticket-012.yaml
├── checks/
│   ├── ticket-001-check.sh
│   ├── ticket-004-check.sh
│   └── ticket-012-check.sh
└── setup/
    ├── ticket-001/
    │   └── setup.sh
    ├── ticket-004/
    │   ├── setup.sh
    │   └── assets/
    │       └── startup.conf
    └── ticket-012/
        └── setup.sh
```

---

## 📄 `exam.yaml` Format

This file defines the contents, configuration, and metadata for the exam session.

### Required Fields

| Field         | Type     | Description |
|---------------|----------|-------------|
| `id`          | string   | Unique ID for the exam bundle |
| `title`       | string   | Display title of the exam |
| `version`     | string   | Version tag of the bundle (e.g., `v1`, `2025`) |
| `exam_type`   | string   | One of: `Linux+`, `LPIC-1`, `LFCS`, `RHCSA`, etc. |
| `duration`    | integer  | Time limit in minutes |
| `includes`    | list     | List of ticket IDs included |
| `distribution_weights` | object | Map of domain → percentage of tickets |
| `compatible_distros` | list | Base images this exam can run on |
| `architecture` | list    | Supported architectures |

### Example Format

```yaml
id: linuxplus-basic
title: "Linux+ Terminal Exam — Core Skills"
version: "v1.0"
exam_type: "Linux+"
duration: 90  # in minutes

includes:
  - ticket-001
  - ticket-004
  - ticket-012
  - ticket-021
  - ticket-025

distribution_weights:
  "1.0": 20   # System Management
  "2.0": 20   # Security
  "3.0": 40   # Commands and Tools
  "4.0": 20   # Networking

compatible_distros:
  - ubuntu
  - debian

architecture:
  - amd64
  - arm64
```

---

## 🎯 Ticket Selection Logic

Tickets are selected from the global `/tickets/` pool by:

1. Filtering tickets that match the exam name/version in their `objectives_map`
2. Grouping by domain
3. Applying selection weights to randomly choose a number of tickets per domain
4. Copying matching `ticket.yaml`, `check_script`, and `setup.sh` into the bundle
5. Writing the result into `exam.yaml`

> Ticket count is fixed or parameterized (e.g., 10 questions, 90 mins).

---

## 📁 Runtime Behavior

Upon container startup:
1. Parse the `exam.yaml`
2. Display intro, timer, and ticket index
3. Load each ticket in sequence (or present all at once)
4. Allow the user to trigger the checker script per ticket
5. Track score and completion time
6. Save exam results to `/results/summary.json`

---

## 🔄 Result Format (summary.json)

A possible result schema might include:

- Ticket ID
- Outcome (pass/fail)
- Time spent
- Flags found (if applicable)
- Score summary

> TBD: Not finalized — to be defined in `result-spec.md`

---

## 🛠️ Future Extensions

- `static_seed`: for deterministic ticket selection
- `randomize_order`: for shuffling
- `mode`: interactive / full exam / training
- CTFd-compatible export structure
- In-container `examctl` CLI or TUI frontend

---
