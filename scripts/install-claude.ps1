$ErrorActionPreference = "Stop"

$repo = "https://raw.githubusercontent.com/skher9/Wingman/main"
$dest = ".claude\commands\wingman.md"

Write-Host "Installing wingman for Claude Code..."

New-Item -ItemType Directory -Force -Path ".claude\commands" | Out-Null

try {
    Invoke-WebRequest -Uri "$repo/claude-code/wingman.md" -OutFile $dest -UseBasicParsing
} catch {
    Write-Host ""
    Write-Host "Error: download failed. $_"
    Write-Host "Manual install: download https://github.com/skher9/Wingman/blob/main/claude-code/wingman.md"
    Write-Host "Save to: .claude\commands\wingman.md"
    exit 1
}

Write-Host "✓ Done. Open Claude Code in this project and type /wingman all to get started."
