Write-Host "Starting safe Windows debloat..."

$apps = @(
    "*Clipchamp*",
    "*Xbox*",
    "*MicrosoftSolitaireCollection*",
    "*MicrosoftTeams*",
    "*SkypeApp*",
    "*GetHelp*",
    "*People*",
    "*WindowsMaps*",
    "*YourPhone*",
    "*FeedbackHub*",
    "*ZuneMusic*",
    "*ZuneVideo*",
    "*Family*"
)

foreach ($app in $apps) {
    try {
        Get-AppxPackage -AllUsers $app | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    } catch {}
}

# Disable telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

# Disable web search in start menu
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f

# Show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f

# Show hidden files
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f

# Enable long paths
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f

# High performance power plan
powercfg /setactive SCHEME_MIN

Write-Host "Debloat complete."