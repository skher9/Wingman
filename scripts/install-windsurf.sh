#!/usr/bin/env bash
set -e

REPO="https://raw.githubusercontent.com/skher9/Wingman/main"
DEST=".windsurfrules"
TMP=$(mktemp)

echo "Installing wingman for Windsurf..."

if command -v curl &>/dev/null; then
  curl -fsSL "$REPO/windsurf/.windsurfrules" -o "$TMP"
elif command -v wget &>/dev/null; then
  wget -q "$REPO/windsurf/.windsurfrules" -O "$TMP"
else
  echo ""
  echo "Error: curl or wget required."
  echo "Manual install: download https://github.com/skher9/Wingman/blob/main/windsurf/.windsurfrules"
  echo "Append to: .windsurfrules in your project root"
  exit 1
fi

if [ $? -ne 0 ]; then
  rm -f "$TMP"
  echo ""
  echo "Error: download failed."
  echo "Manual install: download https://github.com/skher9/Wingman/blob/main/windsurf/.windsurfrules"
  echo "Append to: .windsurfrules in your project root"
  exit 1
fi

if [ -f "$DEST" ]; then
  echo "" >> "$DEST"
  echo "# --- wingman QA toolkit ---" >> "$DEST"
  cat "$TMP" >> "$DEST"
  echo "✓ Done. Wingman appended to existing .windsurfrules."
else
  mv "$TMP" "$DEST"
  echo "✓ Done. Created .windsurfrules with wingman."
fi

rm -f "$TMP"
echo "In Windsurf, type: wingman nitpick — or any subcommand — to run an analysis."
