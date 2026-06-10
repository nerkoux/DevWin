$base = "https://provision.akshatmehta.com"

Clear-Host

Write-Host ""
Write-Host "======================================="
Write-Host "         Developer Bootstrap"
Write-Host "======================================="
Write-Host ""
Write-Host "[1] Safe Debloat"
Write-Host "[2] Developer Environment"
Write-Host "[3] Debloat + Developer Environment"
Write-Host "[4] Exit"
Write-Host ""

$choice = Read-Host "Select an option"

switch ($choice) {

    "1" {
        Write-Host ""
        Write-Host "Running Debloat..."
        irm "$base/debloat" | iex
    }

    "2" {
        Write-Host ""
        Write-Host "Running Developer Setup..."
        irm "$base/devsetup" | iex
    }

    "3" {
        Write-Host ""
        Write-Host "Running Debloat..."
        irm "$base/debloat" | iex

        Write-Host ""
        Write-Host "Running Developer Setup..."
        irm "$base/devsetup" | iex
    }

    default {
        Write-Host "Exiting..."
    }
}
