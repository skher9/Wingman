#!/usr/bin/env bash
set -e

echo "Installing wingman into your project..."

mkdir -p .claude/commands

URL="https://raw.githubusercontent.com/YOUR_USERNAME/wingman/main/.claude/commands/wingman.md"
DEST=".claude/commands/wingman.md"

if command -v curl &>/dev/null; then
  curl -fsSL "$URL" -o "$DEST"
elif command -v wget &>/dev/null; then
  wget -q "$URL" -O "$DEST"
else
  echo "Error: curl or wget required." >&2
  exit 1
fi

echo "✓ Done. Open Claude Code and type /wingman all to get started."
