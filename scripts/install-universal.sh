#!/usr/bin/env bash
set -e

REPO="https://raw.githubusercontent.com/skher9/Wingman/main"
DEST="wingman-prompt.md"

echo "Installing wingman universal prompt..."

if command -v curl &>/dev/null; then
  curl -fsSL "$REPO/universal/wingman-prompt.md" -o "$DEST"
elif command -v wget &>/dev/null; then
  wget -q "$REPO/universal/wingman-prompt.md" -O "$DEST"
else
  echo ""
  echo "Error: curl or wget required."
  echo "Manual install: download https://github.com/skher9/Wingman/blob/main/universal/wingman-prompt.md"
  exit 1
fi

if [ $? -ne 0 ]; then
  echo ""
  echo "Error: download failed."
  echo "Manual install: download https://github.com/skher9/Wingman/blob/main/universal/wingman-prompt.md"
  exit 1
fi

echo "✓ Done. wingman-prompt.md saved to this directory."
echo ""
echo "How to use:"
echo "  ChatGPT  → paste into System Prompt in Custom GPT or My Instructions"
echo "  Claude.ai → paste into Project Instructions"
echo "  Gemini   → paste at the start of your conversation"
echo "  Any AI   → paste as system prompt before your message"
echo ""
echo "Then type: wingman [subcommand]"
