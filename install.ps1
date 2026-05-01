Write-Host "Installing wingman into your project..."

$dest = ".claude\commands"
if (-not (Test-Path $dest)) {
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
}

$url  = "https://raw.githubusercontent.com/YOUR_USERNAME/wingman/main/.claude/commands/wingman.md"
$file = ".claude\commands\wingman.md"

Invoke-WebRequest -Uri $url -OutFile $file -UseBasicParsing

Write-Host "✓ Done. Open Claude Code and type /wingman all to get started."
