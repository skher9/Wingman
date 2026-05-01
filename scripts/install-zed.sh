#!/usr/bin/env bash
set -e

REPO="https://raw.githubusercontent.com/skher9/Wingman/main"
DEST=".zed/wingman.json"

echo "Installing wingman for Zed..."

mkdir -p ".zed"

if command -v curl &>/dev/null; then
  curl -fsSL "$REPO/zed/wingman.json" -o "$DEST"
elif command -v wget &>/dev/null; then
  wget -q "$REPO/zed/wingman.json" -O "$DEST"
else
  echo ""
  echo "Error: curl or wget required."
  echo "Manual install: download https://github.com/skher9/Wingman/blob/main/zed/wingman.json"
  echo "Save to: .zed/wingman.json"
  exit 1
fi

if [ $? -ne 0 ]; then
  echo ""
  echo "Error: download failed."
  echo "Manual install: download https://github.com/skher9/Wingman/blob/main/zed/wingman.json"
  echo "Save to: .zed/wingman.json"
  exit 1
fi

echo "✓ Done. In Zed, open the AI assistant and select the wingman context to activate it."
echo "Then type: wingman nitpick — or any subcommand — to run an analysis."
