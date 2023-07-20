$ProfileDirectory = "$HOME\Documents\Powershell"
. $ProfileDirectory\Variables.ps1
. $ProfileDirectory\FunctionsAndAliases.ps1
. $ProfileDirectory\PSSettings.ps1
. $ProfileDirectory\Prompt.ps1
. $ProfileDirectory\Completions.ps1

Import-Module posh-git
Import-Module Pansies
Import-Module QuickIp
Import-Module PublishProject
Import-Module TestNodeJSVersion
