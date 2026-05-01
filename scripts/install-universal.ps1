$ErrorActionPreference = "Stop"

$repo = "https://raw.githubusercontent.com/skher9/Wingman/main"
$dest = "wingman-prompt.md"

Write-Host "Installing wingman universal prompt..."

try {
    Invoke-WebRequest -Uri "$repo/universal/wingman-prompt.md" -OutFile $dest -UseBasicParsing
} catch {
    Write-Host ""
    Write-Host "Error: download failed. $_"
    Write-Host "Manual install: download https://github.com/skher9/Wingman/blob/main/universal/wingman-prompt.md"
    exit 1
}

Write-Host "✓ Done. wingman-prompt.md saved to this directory."
Write-Host ""
Write-Host "How to use:"
Write-Host "  ChatGPT   -> paste into System Prompt in Custom GPT or My Instructions"
Write-Host "  Claude.ai -> paste into Project Instructions"
Write-Host "  Gemini    -> paste at the start of your conversation"
Write-Host "  Any AI    -> paste as system prompt before your message"
Write-Host ""
Write-Host "Then type: wingman [subcommand]"
