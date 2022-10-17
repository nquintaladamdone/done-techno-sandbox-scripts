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
# Install all dependencies ==========================================================================================
# ===================================================================================================================
$wingetPackages =
"Git.Git",
"Google.Chrome",
"Python.Python.3.9",
"CoreyButler.NVMforWindows",
"Microsoft.VisualStudioCode",
"Microsoft.SQLServer.2019.Express",
"Microsoft.SQLServerManagementStudio",
"Microsoft.VisualStudio.2022.BuildTools",
"Microsoft.VisualStudio.2022.Enterprise",
"Docker.DockerDesktop",
"Microsoft.AzureStorageExplorer",
"SlackTechnologies.Slack",
"Postman.Postman",
"Microsoft.Teams"

foreach ($wingetPackage in $wingetPackages) {
    winget install --exact --id $wingetPackage --silent --accept-package-agreements --accept-source-agreements
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