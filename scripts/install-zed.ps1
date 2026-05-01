$ErrorActionPreference = "Stop"

$repo = "https://raw.githubusercontent.com/skher9/Wingman/main"
$dest = ".zed\wingman.json"

Write-Host "Installing wingman for Zed..."

New-Item -ItemType Directory -Force -Path ".zed" | Out-Null

try {
    Invoke-WebRequest -Uri "$repo/zed/wingman.json" -OutFile $dest -UseBasicParsing
} catch {
    Write-Host ""
    Write-Host "Error: download failed. $_"
    Write-Host "Manual install: download https://github.com/skher9/Wingman/blob/main/zed/wingman.json"
    Write-Host "Save to: .zed\wingman.json"
    exit 1
}

Write-Host "✓ Done. In Zed, open the AI assistant and select the wingman context to activate it."
Write-Host "Then type: wingman nitpick — or any subcommand — to run an analysis."
