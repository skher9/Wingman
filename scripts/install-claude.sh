#!/usr/bin/env bash
set -e

REPO="https://raw.githubusercontent.com/skher9/Wingman/main"
DEST=".claude/commands/wingman.md"

echo "Installing wingman for Claude Code..."

mkdir -p ".claude/commands"

if command -v curl &>/dev/null; then
  curl -fsSL "$REPO/claude-code/wingman.md" -o "$DEST"
elif command -v wget &>/dev/null; then
  wget -q "$REPO/claude-code/wingman.md" -O "$DEST"
else
  echo ""
  echo "Error: curl or wget required."
  echo "Manual install: download https://github.com/skher9/Wingman/blob/main/claude-code/wingman.md"
  echo "Save to: .claude/commands/wingman.md"
  exit 1
fi

if [ $? -ne 0 ]; then
  echo ""
  echo "Error: download failed."
  echo "Manual install: download https://github.com/skher9/Wingman/blob/main/claude-code/wingman.md"
  echo "Save to: .claude/commands/wingman.md"
  exit 1
fi

echo "✓ Done. Open Claude Code in this project and type /wingman all to get started."
