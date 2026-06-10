Write-Host "Starting developer environment installation..."

Start-Sleep -Seconds 30

winget source update

$packages = @(

    # Browser
    "Mozilla.Firefox",

    # Editors
    "Microsoft.VisualStudioCode",
    "CursorAI.Cursor",
    "Microsoft.VisualStudio.2022.Community",

    # Core Tools
    "Git.Git",
    "GitHub.cli",
    "GitHub.GitHubDesktop",
    "Microsoft.PowerShell",
    "Microsoft.WindowsTerminal",
    "7zip.7zip",

    # Languages
    "OpenJS.NodeJS.LTS",
    "Python.Python.3.13",
    "Rustlang.Rustup",
    "GoLang.Go",
    "Microsoft.OpenJDK.21",

    # Containers & DevOps
    "Docker.DockerDesktop",
    "Kubernetes.kubectl",
    "Helm.Helm",
    "Hashicorp.Terraform",

    # Databases
    "DBeaver.DBeaver",

    # Networking
    "WiresharkFoundation.Wireshark",
    "Insecure.Nmap",

    # Utilities
    "Microsoft.PowerToys",
    "voidtools.Everything",
    "ShareX.ShareX",
    "Obsidian.Obsidian",
    "Notepad++.Notepad++",

    # API
    "Postman.Postman",

    # AI
    "Ollama.Ollama"
)

foreach ($pkg in $packages) {

    Write-Host "Installing $pkg"

    winget install `
        --id $pkg `
        --exact `
        --silent `
        --accept-package-agreements `
        --accept-source-agreements
}

# Enable virtualization features

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Containers -All -NoRestart

# Install Ubuntu

try {
    wsl --install -d Ubuntu
} catch {}

# Node ecosystem

npm install -g pnpm
npm install -g yarn

# Python ecosystem

pip install --upgrade pip
pip install pipx
pip install uv
pip install poetry

# Git defaults

git config --global init.defaultBranch main

# Workspace folders

New-Item "$env:USERPROFILE\Projects" -ItemType Directory -Force
New-Item "$env:USERPROFILE\Projects\Personal" -ItemType Directory -Force
New-Item "$env:USERPROFILE\Projects\Work" -ItemType Directory -Force
New-Item "$env:USERPROFILE\Projects\Labs" -ItemType Directory -Force

# VS Code extensions

$code = "$env:ProgramFiles\Microsoft VS Code\bin\code.cmd"

if (Test-Path $code) {

    $extensions = @(
        "esbenp.prettier-vscode",
        "dbaeumer.vscode-eslint",
        "eamodio.gitlens",
        "ms-python.python",
        "ms-python.vscode-pylance",
        "ms-vscode-remote.remote-wsl",
        "ms-azuretools.vscode-docker",
        "rust-lang.rust-analyzer",
        "golang.go",
        "bradlc.vscode-tailwindcss",
        "usernamehw.errorlens",
        "github.copilot"
    )

    foreach ($ext in $extensions) {
        & $code --install-extension $ext --force
    }
}

Write-Host "Developer setup complete."