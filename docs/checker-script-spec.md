# 🧪 Checker Script Specification

This document defines the format and expectations for all ticket checker scripts in the SysAdmin Simulator project. These scripts validate whether a ticket has been successfully completed in a given container environment.

---

## 🧠 Script Purpose

Each `check_script` executes in the container where the user has performed ticket tasks. It inspects the system state (services, files, users, configurations, etc.) to verify success.

---

## 🐚 Required Language

All checker scripts **must** be written in **Bash**.

- Shebang: `#!/bin/bash` required at top
- Do not use Python, Perl, or other languages
- Reason: maximum compatibility across base images

---

## ✅ Script Requirements

| Feature             | Required | Notes |
|---------------------|----------|-------|
| Bash shebang        | ✅       | `#!/bin/bash` at top |
| Distro check        | ✅       | Validate `ID` from `/etc/os-release` |
| Architecture check  | ✅       | Validate `uname -m` is supported |
| Clear feedback      | ✅       | Echo meaningful messages |
| Exit codes          | ✅       | `0 = success`, non-zero = failure |

---

## 🧾 Distro & Architecture Detection

All checker scripts must validate that they are being run in a supported ticket environment.

Use the following convention:

```bash
#!/bin/bash

ARCH=$(uname -m)
DISTRO=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"')

if [[ "$ARCH" != "x86_64" && "$ARCH" != "aarch64" ]]; then
  echo "❌ Unsupported architecture: $ARCH"
  exit 2
fi

if [[ "$DISTRO" != "ubuntu" && "$DISTRO" != "debian" ]]; then
  echo "❌ Unsupported distribution: $DISTRO"
  exit 2
fi
```

---

## 🧪 Exit Codes

| Code | Meaning              |
|------|----------------------|
| `0`  | Ticket success        |
| `1`  | Failure: incorrect setup |
| `2`  | Failure: wrong environment (unsupported arch/distro) |

---

## 📢 Output Expectations

Checker scripts **must echo meaningful output** for the user:

```bash
echo "✅ SSH service is running"
echo "✅ Port 22 is open"
echo "❌ User 'webdev' is missing"
```
---

## 🧩 Tips
- Use systemctl is-active, grep, ss -tuln, or test -f as appropriate
- Use set -e and proper if blocks for control flow
- Keep logic minimal and reliable
- Don't rely on fancy terminal UI — just echo output

---

## 🔐 Flag Output (Optional)
If the ticket uses a flag, it should be output only when success is verified:

```bash
echo "LINUX{firewall_rules_applied}"
```
Never echo the flag unless all successful conditions are met.

---

## 🧰 Recommended Script Skeleton

```bash
#!/bin/bash
set -e

# Check environment
ARCH=$(uname -m)
DISTRO=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"')

if [[ "$ARCH" != "x86_64" && "$ARCH" != "aarch64" ]]; then
  echo "❌ Unsupported architecture: $ARCH"
  exit 2
fi

if [[ "$DISTRO" != "ubuntu" && "$DISTRO" != "debian" ]]; then
  echo "❌ Unsupported distribution: $DISTRO"
  exit 2
fi

# Validate objectives
echo "🔍 Checking SSH service..."
if systemctl is-active --quiet ssh; then
  echo "✅ SSH is running"
else
  echo "❌ SSH is not running"
  exit 1
fi

echo "✅ Ticket passed!"
echo "LINUX{ssh_success_flag}"
exit 0

```

---

## 🔄 Future Extensions
Planned fields:

- required_packages
- expected_services
- JSON result output for CTFd exports
