if (([Environment]::GetEnvironmentVariable("POWERSHELL_UPDATECHECK")) -ne "Off") {
  [Environment]::SetEnvironmentVariable("POWERSHELL_UPDATECHECK", "Off", [System.EnvironmentVariableTarget]::User)
}

# https://github.com/microsoft/terminal/issues/3821#issuecomment-802548767
#$vsInstallPath = "E:\PROGRAMS\VISUAL_STUDIO\2022\Community"
#Import-Module "$vsInstallPath/Common7/Tools/Microsoft.VisualStudio.DevShell.dll"
#Enter-VsDevShell -VsInstallPath $vsInstallPath -SkipAutomaticLocation

$ProfileDirectory = "$HOME\Documents\Powershell"
$FleschutzPwsh = "$ProfileDirectory\fleschutz__Powershell\scripts"
$DotfilesDir = "E:\files\a_important\PROGRAMS"
#$MyModulesDir = "E:\files\a_important\Powershell_Modules"

# $env:DOTNET_CLI_UI_LANGUAGE = "en_US"
$env:DOTNET_CLI_UI_LANGUAGE = "en-us"
$env:PSModulePath = "$MyModulesDir;C:\Users\ivan\Documents\PowerShell\Modules;C:\Program Files\PowerShell\Modules;c:\program files\powershell\7\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules"

Remove-Item Alias:ni -Force -ErrorAction Ignore

$GeneralProfile = $PROFILE.CurrentUserAllHosts

# https://github.com/PowerShell/vscode-powershell/issues/1074
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

$PromptProgram = "my"

# Import-Module npm-completion
# Import-Module CompletionPredictor
# Import-Module posh-git
Import-Module Pansies

. $ProfileDirectory\FunctionsAndAliases.ps1
. $ProfileDirectory\PSSettings.ps1
. $ProfileDirectory\Prompt.ps1
. $ProfileDirectory\Completions.ps1
