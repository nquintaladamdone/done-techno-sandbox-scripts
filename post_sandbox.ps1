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
# Install Node.js ===================================================================================================
# ===================================================================================================================
nvm install lts
nvm use lts

# ===================================================================================================================
# Install TypeScript ================================================================================================
# ===================================================================================================================
npm install typescript --g

# ===================================================================================================================
# Set Chrome homepage ===============================================================================================
# ===================================================================================================================

$homepageSourcePath = Join-Path $PSScriptRoot "homepage.html"
$myDocumentsDirectory = ([Environment]::GetFolderPath("MyDocuments"))
Copy-Item $homepageSourcePath -Destination $myDocumentsDirectory

# Tentative par les group policies
# $homepageSourcePath = Join-Path $PSScriptRoot "homepage.html"
# $myDocumentsDirectory = ([Environment]::GetFolderPath("MyDocuments"))
# $homepageDestinationPath = Join-Path $myDocumentsDirectory "homepage.html"
# $googleRegistryKey = "HKLM:\SOFTWARE\Policies\Google"
# $googleChromeRegistryKey = "HKLM:\SOFTWARE\Policies\Google\Chrome"
# $googleChromeRegistryKeyExists = Test-Path $googleChromeRegistryKey

# Copy-Item $homepageSourcePath -Destination $myDocumentsDirectory

# if ($googleChromeRegistryKeyExists -eq $true) {
#     Set-ItemProperty -Path $googleChromeRegistryKey -Name HomepageLocation -Value $homepageDestinationPath
#     Set-ItemProperty -Path $googleChromeRegistryKey -Name NewTabPageLocation -Value $homepageDestinationPath    
#     Set-ItemProperty -Path $googleChromeRegistryKey -Name HomepageIsNewTabPage -Value 0
# }
# else {
#     New-Item -path $googleRegistryKey
#     New-Item -path $googleChromeRegistryKey
#     New-ItemProperty -path $googleChromeRegistryKey -Name HomepageLocation -PropertyType String -Value $homepageDestinationPath
#     New-ItemProperty -path $googleChromeRegistryKey -Name NewTabPageLocation -PropertyType String -Value $homepageDestinationPath
#     New-ItemProperty -path $googleChromeRegistryKey -Name HomepageIsNewTabPage -PropertyType DWord -Value 0
# }

# Tentative par le fichier de configuration
# $chromePreferencesPath = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) "Google\Chrome\User Data\Default\Secure Preferences"
# $chromePreferencesJson = Get-Content $chromePreferencesPath | ConvertFrom-Json
# $chromePreferencesJson.homepage = '"file:///C:/Users/Nicolas/Documents/homepage.html"'
# $chromePreferencesJson.homepage_is_newtabpage = "false"
# $chromePreferencesJson | ConvertTo-Json | Out-File $chromePreferencesPath

# ===================================================================================================================
# Wait for user input ===============================================================================================
# ===================================================================================================================
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');