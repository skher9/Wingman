$ErrorActionPreference = "Stop"

$repo = "https://raw.githubusercontent.com/skher9/Wingman/main"
$dest = ".windsurfrules"
$tmp  = [System.IO.Path]::GetTempFileName()

Write-Host "Installing wingman for Windsurf..."

try {
    Invoke-WebRequest -Uri "$repo/windsurf/.windsurfrules" -OutFile $tmp -UseBasicParsing
} catch {
    Write-Host ""
    Write-Host "Error: download failed. $_"
    Write-Host "Manual install: download https://github.com/skher9/Wingman/blob/main/windsurf/.windsurfrules"
    Write-Host "Append to: .windsurfrules in your project root"
    exit 1
}

if (Test-Path $dest) {
    Add-Content -Path $dest -Value ""
    Add-Content -Path $dest -Value "# --- wingman QA toolkit ---"
    Get-Content $tmp | Add-Content -Path $dest
    Write-Host "✓ Done. Wingman appended to existing .windsurfrules."
} else {
    Move-Item -Path $tmp -Destination $dest
    Write-Host "✓ Done. Created .windsurfrules with wingman."
}

Remove-Item -Path $tmp -ErrorAction SilentlyContinue
Write-Host "In Windsurf, type: wingman nitpick — or any subcommand — to run an analysis."
