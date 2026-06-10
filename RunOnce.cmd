@echo off

echo ====================================
echo Windows Developer Workstation Setup
echo ====================================

powershell.exe -ExecutionPolicy Bypass -File C:\Setup\debloat.ps1

powershell.exe -ExecutionPolicy Bypass -File C:\Setup\devsetup.ps1

echo.
echo Setup Complete.
echo Rebooting in 60 seconds...

shutdown /r /t 60