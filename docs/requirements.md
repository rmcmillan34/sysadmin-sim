# SysAdmin Simulator – Requirements Document

## 1. Purpose
This project simulates the day-to-day tasks of a Linux system administrator using a CLI-based ticketing system. Users solve real-world Linux+ and LPIC-style tasks via simulated helpdesk tickets in a sandboxed environment.

## 2. Target Audience
- Aspiring Linux sysadmins
- Students preparing for CompTIA Linux+ and LPIC exams
- Hobbyists and learners interested in hands-on command-line practice

## 3. Goals
- Simulate realistic Linux tasks in a CLI-only environment
- Align content with the Linux+ and LPIC curriculum
- Run inside Docker containers with multi-distro and multi-arch support
- Enable sandboxed task solving with automated feedback
- Offer progressive ticket difficulty and tracking

## 4. Functional Requirements

### 4.1 Ticket System
- Tickets stored in `tickets/` as YAML/text
- Each ticket includes:
  - ID
  - Difficulty level
  - Topic tags
  - Description
  - Hints (optional, tiered)
  - Associated checker script

### 4.2 User Interface
- Command-line tool: `ticket-cli`
- View available tickets
- View ticket details
- Submit or check solution
- View hints (if allowed)

### 4.3 Ticket Notification
- Root-level background service monitors for new tickets
- Alerts via `wall`, `write`, or TTY messaging
- Optional: launch TUI in user terminal automatically

### 4.4 Solution Evaluation
- Checker scripts verify resolution
- Result: pass/fail + explanation
- Logs stored in `~/.ticket-sim/history.log`

### 4.5 Progress Tracking
- Tracks ticket completion history
- Optional levels, ranks, or scores

### 4.6 Sandbox Environment
- Isolated environment per ticket (Docker, chroot, or namespace)
- Resettable state
- Includes common services and configs (e.g., cron, systemd, web server)

### 4.7 Multi-Distribution Support
- Dockerfiles for Ubuntu, Alpine, CentOS, etc.
- Multi-arch builds: `linux/amd64`, `linux/arm64`
- Uses Docker Buildx or GitHub Actions for CI

## 5. Non-Functional Requirements
- CLI-only interface
- Offline operation
- Lightweight and efficient
- Modular for easy ticket and environment additions

## 6. Technical Stack
- Bash for CLI scripting
- Python or Go for advanced tooling
- Docker for isolation and portability
- TTY notification tools (`wall`, `script`, `tmux`)
- Systemd or cron for background jobs

## 7. Stretch Goals
- **Timer System**: Timed challenges per ticket with optional penalties/rewards
- **Difficulty-Based Hint System**: Limited hints based on selected difficulty
- **Multiplayer Mode**: Multiple users solving or collaborating
- **Leaderboard / Badges**: Gamified progression
- **Web Dashboard**: Local web interface showing progress
- **Email Integration**: Deliver tickets via local mail system