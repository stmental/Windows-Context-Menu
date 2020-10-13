##Requires -RunAsAdministrator
############################################################
# David Foster
# 5/5/2020
# 
# Purpose:
# Interactive installation of custom context menu options
############################################################

# By default, the power shell registry provider only has HKEY_CURRENT_USER and HKEY_LOCAL_MACHINE, but we
# want access to HKEY_CLASSES_ROOT, so add a new registry provider
# See https://devblogs.microsoft.com/scripting/use-the-powershell-registry-provider-to-simplify-registry-access/
New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR | Out-Null

# Function to print a prompt and wait for a response
Function Get-Response {
    param(
        [string] $Response,
        [string] $message
        )
    While ( ($Null -eq $Response) -or ($Response -eq '') ) {
        $Response = Read-Host -Prompt "$message"
    }
    Return $Response.ToUpper()
}

# Must run as admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")
if (-Not $isAdmin){
    Write-Host "This script must be run in administrator mode" -ForegroundColor Red
    exit
}

if ((Test-Path 'HKCR:\Directory\shell\01MenuCmd') -and
    (Test-Path 'HKCR:\Directory\shell\02MenuVSCmd') -and
    (Test-Path 'HKCR:\Directory\shell\03MenuVSCodeCmd') -and
    (Test-Path 'HKCR:\Directory\shell\04MenuPowershellCmd')){
    Write-Host "Context menus are already fully installed" -ForegroundColor Green
    exit
}

try {
    # If the registry entry doesn't already exist and the command is available, prompt to install
    if (-Not (Test-Path 'HKCR:\Directory\shell\01MenuCmd')){
        if (Get-Command -CommandType application -Name cmd.exe -ErrorAction Stop){
            $installResponse = Get-Response -Response $installResponse -message "Install cmd context menu? (Y/N)"
            if ($installResponse -eq 'Y'){
                Write-Host "`tInstalling cmd context menu..." -ForegroundColor yellow -NoNewline
                reg import .\custom_cmd_context_menu_prompts.reg
                Write-Host "Done!" -ForegroundColor yellow
            }
        }
    }
}
catch{
    Write-Host "Could not find cmd.exe" -ForegroundColor Red
}

# Check for Visual Studio 2019 and 2017 Enterprise, Professional and Community editions
if (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\devenv.exe"){
    if (-Not (Test-Path 'HKCR:\Directory\shell\02MenuVSCmd')){
        $installResponse = $null
        $installResponse = Get-Response -Response $installResponse -message "Install Visual Studio 2019 Enterprise Dev Console context menu? (Y/N)"
        if ($installResponse -eq 'Y'){
            Write-Host "`tInstalling VS dev console context menu..." -ForegroundColor yellow -NoNewline
            reg import .\custom_vs2019_enterprise_context_menu_prompts.reg
            Write-Host "Done!" -ForegroundColor yellow
        }
    }
} elseif (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\devenv.exe"){
    if (-Not (Test-Path 'HKCR:\Directory\shell\02MenuVSCmd')){
        $installResponse = $null
        $installResponse = Get-Response -Response $installResponse -message "Install Visual Studio 2019 Community Dev Console context menu? (Y/N)"
        if ($installResponse -eq 'Y'){
            Write-Host "`tInstalling VS dev console context menu..." -ForegroundColor yellow -NoNewline
            reg import .\custom_vs2019_professional_context_menu_prompts.reg
            Write-Host "Done!" -ForegroundColor yellow
        }
    }
} elseif (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe"){
    if (-Not (Test-Path 'HKCR:\Directory\shell\02MenuVSCmd')){
        $installResponse = $null
        $installResponse = Get-Response -Response $installResponse -message "Install Visual Studio 2019 Community Dev Console context menu? (Y/N)"
        if ($installResponse -eq 'Y'){
            Write-Host "`tInstalling VS dev console context menu..." -ForegroundColor yellow -NoNewline
            reg import .\custom_vs2019_community_context_menu_prompts.reg
            Write-Host "Done!" -ForegroundColor yellow
        }
    }
} elseif (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.exe"){
    if (-Not (Test-Path 'HKCR:\Directory\shell\02MenuVSCmd')){
        $installResponse = $null
        $installResponse = Get-Response -Response $installResponse -message "Install Visual Studio 2017 Enterprise Dev Console context menu? (Y/N)"
        if ($installResponse -eq 'Y'){
            Write-Host "`tInstalling VS dev console context menu..." -ForegroundColor yellow -NoNewline
            reg import .\custom_vs2017_enterprise_context_menu_prompts.reg
            Write-Host "Done!" -ForegroundColor yellow
        }
    }
} elseif (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"){
    if (-Not (Test-Path 'HKCR:\Directory\shell\02MenuVSCmd')){
        $installResponse = $null
        $installResponse = Get-Response -Response $installResponse -message "Install Visual Studio2017 Professional Dev Console context menu? (Y/N)"
        if ($installResponse -eq 'Y'){
            Write-Host "`tInstalling VS dev console context menu..." -ForegroundColor yellow -NoNewline
            reg import .\custom_vs2017_professional_context_menu_prompts.reg
            Write-Host "Done!" -ForegroundColor yellow
        }
    }
} elseif (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"){
    if (-Not (Test-Path 'HKCR:\Directory\shell\02MenuVSCmd')){
        $installResponse = $null
        $installResponse = Get-Response -Response $installResponse -message "Install Visual Studio 2017 Community Dev Console context menu? (Y/N)"
        if ($installResponse -eq 'Y'){
            Write-Host "`tInstalling VS dev console context menu..." -ForegroundColor yellow -NoNewline
            reg import .\custom_vs2017_community_context_menu_prompts.reg
            Write-Host "Done!" -ForegroundColor yellow
        }
    }
} else {
    Write-Host "Could not find Visual Studio 2019 or 2017" -ForegroundColor Red
}

if (Test-Path "C:\Program Files\Microsoft VS Code\Code.exe"){
    if (-Not (Test-Path 'HKCR:\Directory\shell\03MenuVSCodeCmd')){
        $installResponse = $null
        $installResponse = Get-Response -Response $installResponse -message "Install VS Code context menu? (Y/N)"
        if ($installResponse -eq 'Y'){
            Write-Host "`tInstalling vs code context menu..." -ForegroundColor yellow -NoNewline
            reg import .\custom_vscode_context_menu_prompts.reg
            Write-Host "Done!" -ForegroundColor yellow
        }
    }
} else {
    Write-Host "Could not find VS Code" -ForegroundColor Red
}


if (Test-Path "C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe"){
    if (-Not (Test-Path 'HKCR:\Directory\shell\04MenuPowershellCmd')){
        $installResponse = $null
        $installResponse = Get-Response -Response $installResponse -message "Install powershell context menu? (Y/N)"
        if ($installResponse -eq 'Y'){
            Write-Host "`tInstalling powershell context menu..." -ForegroundColor yellow -NoNewline
            reg import .\custom_powershell_context_menu_prompts.reg
            Write-Host "Done!" -ForegroundColor yellow
        }
    }
} else {
    Write-Host "Could not find powershell.exe" -ForegroundColor Red
}
