#!/bin/bash
set -e

ARCH=$(uname -m)
DISTRO=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"')

if [[ "$ARCH" != "x86_64" && "$ARCH" != "aarch64" ]]; then
  echo "❌ Unsupported architecture: $ARCH"
  exit 2
fi

if [[ "$DISTRO" != "ubuntu" && "$DISTRO" != "debian" && "$DISTRO" != "fedora" && "$DISTRO" != "rocky" && "$DISTRO" != "alpine" ]]; then
  echo "❌ Unsupported distribution: $DISTRO"
  exit 2
fi

REPORT="/tmp/tools_listing.txt"

if [[ ! -f "$REPORT" ]]; then
  echo "❌ Expected output file not found: $REPORT"
  exit 1
fi

if ! grep -q "ls" "$REPORT"; then
  echo "⚠️  Output may not include ls results for /usr/bin"
  # Continue anyway — we'll be gentle for first ticket
fi

if grep -q "/bin" "$REPORT"; then
  echo "✅ Looks like /usr/bin was listed"
  echo "✅ Beginner shell usage complete"
  echo "LINUX{tools_directory_listed}"
  exit 0
else
  echo "❌ Output does not appear to reflect /usr/bin"
  exit 1
fi
