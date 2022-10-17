# ===================================================================================================================
# We run as Admin ===================================================================================================
# ===================================================================================================================
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { 
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Unrestricted -File `"$PSCommandPath`"" -Verb RunAs; 
    exit;
}

# ===================================================================================================================
# Validate the execution policy =====================================================================================
# ===================================================================================================================
$currentExecutionPolicy = Get-ExecutionPolicy

if ($currentExecutionPolicy -ne "Unrestricted") {
    Set-ExecutionPolicy Unrestricted -force
}

# ===================================================================================================================
# Install Chocolatey ================================================================================================
# ===================================================================================================================
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-WebRequest https://community.chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression

refreshenv

# ===================================================================================================================
# Install all dependencies ==========================================================================================
# ===================================================================================================================
$chocoPackages =
"git",
"googlechrome",
"python",
"nvm",
"typescript",
"vscode",
"sql-server-express",
"sql-server-management-studio",
"visualstudio2022buildtools",
"visualstudio2022-workload-vctools",
"visualstudio2022enterprise",
"docker-desktop",
"microsoftazurestorageexplorer",
"slack",
"postman",
"microsoft-teams"

foreach ($chocoPackage in $chocoPackages) {
    choco install $chocoPackage -y
    refreshenv
}

# ===================================================================================================================
# Install Windows Subsystem for Linux (WSL) =========================================================================
# ===================================================================================================================
wsl --install

# ===================================================================================================================
# Wait for user input ===============================================================================================
# ===================================================================================================================
Write-Host -NoNewLine 'Appuyez sur une touche pour continuer...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');