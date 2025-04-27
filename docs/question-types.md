# Question Types

This document defines the supported `question_type`: values that can be used when authoring tickets for SysAdmin Simulator.
Each ticket must declare a `question_type` in its YAML structure and must align to the defined types below.

---

## Supported Question Types

| `question_type`          | Description |
|--------------------------|-------------|
| `multiple_choice`        | Learner selects the correct answer from the provided options (A, B, C, D, ...etc) and submits it by writing the letter to a designated file. |
| `manpage_retrieval`      | Learner retrieves a specific flag, option or usage detail from a man page or other system documentation. |
| `command_demonstration`  | Learner demonstrates the use of a command, or sequences of commands to produce a verifiable system change or output. |
| 'file_manipulation'      | Learner modifies, creates, moves, or inspects files according to problem objectives. | 
| `configuration_fixing`   | Learner edits system configuration files to fix misbehavior or enforce correct settings. |
| `system_state_validation`| Learner ensures that a defined system state is achieved (e.g., services enabled, permissions corrected, network reachable). |
| `troubleshooting`        | Learner identifies faults in the system and corrects them, such as broken services, misconfigurations, or permission errors. |

---

## Additional Notes

- Tickets must be **script-checkable** without requiring external internet access.
- Authors are encouraged to provide **clear instructions** within the `description` field on how the learner should submit their solution.
- **Hints** may optionally be provided to guide learners through complex scenarios.
- Challenge types may evolve over time as the project expands. However, this document will be updated to reflect the latest supported types.

---

## Example Ticket Structure

```yaml
question_type: multiple_choice

```

For a deeper specification of the ticket fields, please refer to the [ticket specification documentation](ticket-spec.md).


