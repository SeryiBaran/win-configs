# miniserve function
function s {
  [CmdletBinding()]
  param([string]$path = ".", [int]$p = 3000, [string]$ip, [switch]$qr, [switch]$s, [switch]$ForMobile)

  $argsList = [System.Collections.ArrayList]@()

  if ($ForMobile) {
    $argsList += ("--qrcode") # Enable QR code display
    $argsList += ("--interfaces", (Get-IP Ethernet).IPAddress) # Interface to listen on
  }

  if (-Not ($ip -eq "")) {
    $argsList += ("--interfaces", $ip) # Interface to listen on
  }

  if ($qr) {
    $argsList += ("--qrcode") # Enable QR code display
  }

  $argsList += ("--upload-files") # Enable file uploading
  $argsList += ("--mkdir") # Enable creating directories

  $argsList += ("--enable-tar-gz") # Enable gz-compressed tar archive generation
  $argsList += ("--enable-zip") # Enable zip archive generation
  # WARNING: Zipping large directories can result in out-of-memory exception because zip
  # generation is done in memory and cannot be sent on the fly

  $argsList += ("--dirs-first") # List directories first

  $argsList += ("--show-wget-footer") # If enabled, display a wget command to recursively download the current directory

  $argsList += ("--port", $p)

  if ($s) {
    $argsList += ("--index", "index.html")
  }

  $argsList += (, $path)

  miniserve $argsList
}

# dufs function
function ds {
  [CmdletBinding()]
  param([string]$path = ".", [int]$p = 3000, [string]$ip, [switch]$s)

  $argsList = [System.Collections.ArrayList]@()

  if (-Not ($ip -eq "")) {
    $argsList += ("--bind", $ip) # Interface to listen on
  }

  $argsList += ("--allow-all")

  $argsList += ("--port", $p)

  if ($s) {
    $argsList += ("--render-index")
  }

  $argsList += (, $path)

  dufs $argsList
}

function l {
  #lsd -la --header --blocks "size,date,name" --group-directories-first $args
  eza -lah -s type --group-directories-first $args
}

function ll {
  #lsd -la --header --blocks "size,date,name" --group-directories-first $args
  eza -ah -s type --group-directories-first $args
}

function t {
  #lsd -a --tree -I "{node_modules,.git}" --group-directories-first $args
  eza -lah -s type --group-directories-first --tree --ignore-glob ".git|node_modules|.parcel-cache|.cache" $args
}

function m {
  micro $args
}

function n {
  nano $args
}

function npr {
  npm run $args
}

function npi {
  npm install $args
}

function npu {
  npm uninstall $args
}

function c {
  Clear-Host
}

function q {
  exit
}

function qr {
  $input | qrencode -t ANSI256UTF8 $args
}

function qrpng {
  $input | qrencode -o qr.png -s 6 $args
}

function Clear-MyHistory {
  Write-Output "" > (Get-PSReadlineOption).HistorySavePath
}

function gr {
  $input | ugrep -i -e $args
}

function Update-MyHelp {
  Update-Help -Verbose -Force -ErrorAction SilentlyContinue
}

function Backup-PSProfile {
  $items = Get-Item -Path "$ProfileDirectory\*" -Exclude ("Help")

  Remove-Item -Recurse -Force "$DotfilesDir\PowerShell"

  foreach ($item in $items) { Copy-Item $item.FullName -Destination "$DotfilesDir\PowerShell$($item.PSIsContainer ? "\$($item.Name)" : '')" -Recurse -Force }

  Get-ChildItem $HOME\Documents\PowerShell\Modules > $DotfilesDir\pwsh_modules.txt
}

function Backup-AHKScripts {
  Remove-Item -Recurse -Force "$DotfilesDir\AutoHotkey"

  Copy-Item "$HOME\Documents\AutoHotkey" -Destination "$DotfilesDir\AutoHotkey" -Recurse -Force
}

function Get-IP {
  [CmdletBinding()]
  param(
    [alias("i")]
    [string]
    $Interface
  )

  $command_args = @{
    AddressFamily = "IPv4"
  }

  if ($Interface) {
    $command_args.InterfaceAlias = $Interface
  }

  Get-NetIPAddress @command_args | Select-Object -Property InterfaceAlias, IPAddress
}

function tb {
  $input | nc termbin.com 9999
}

function qalc {
  #chcp 866
  qalc.exe -t $args
  #chcp 65001
}

function npp {
  & "C:\Program Files\Notepad++\notepad++.exe" $args
}

function lg {
  lazygit $args
}

function Clear-MyHistory {
  Write-Output "" > (Get-PSReadlineOption).HistorySavePath
}

function Remove-HeadphonesNoise {
  $code =
  @"
import random

while True:
    random.randint(500, 99999)
"@

  Write-Output $code | python
}

function subl {
  & "C:\\Program Files\\Sublime Text\\sublime_text.exe" $args
}

function wf {
  winfetch
}

function ff {
  fastfetch --file $DotfilesDir\FETCH_LOGO.txt --structure Title:Separator:OS:Host:Uptime:Packages:Shell:Monitor:Terminal:TerminalFont:CPU:GPU:Memory:Version:Break:Colors $args
}

function e {
  explorer $PWD $args
}

function dy {
  $input | yt-dlp --compat-option filename-sanitization $args
}

function dc {
  & "C:\\Program Files\\Double Commander\\doublecmd.EXE" -path $PWD $args
}

function tc {
  & "C:\\Program Files\\totalcmd\\TOTALCMD64.EXE" \L $PWD $args
}

function far {
  & "c:\\Program Files\\Far Manager\\Far.exe" $PWD $args
}

function Get-DNSInfo {
  $input | dog -n 192.168.0.1 $args
}

function Show-Colors {
  $Colors = [Enum]::GetValues([ConsoleColor])
  ""
  "Color          As Foreground  As Background"
  "-----          -------------  -------------"
  foreach ($Color in $Colors) {
    $Color = "$Color              "
    $Color = $Color.substring(0, 15)
    write-host -noNewline "$Color"
    write-host -noNewline -foregroundcolor $Color "$Color"
    write-host -noNewline -backgroundcolor $Color "$Color"
    write-host ""
  }
}

function Start-BrowserSyncServer {
  [CmdletBinding()]
  param([int]$p = 3000, [string]$ip = (Get-IP -Interface Ethernet).IPAddress)

  browser-sync start --server --no-open --host $ip --port $p --files "./**/*.{html,css,js}"
}

function Show-PowerShellIntroduction {
  & "$FleschutzPwsh\introduce-powershell.ps1"
}

function Get-TimeISO {
  Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
}

function Backup-WinFetchConfig {
  Copy-Item $HOME\.config\winfetch\config.ps1 $DotfilesDir\winfetch_config.ps1
}

function Backup-WindowsTerminalConfig {
  #Copy-Item "$HOME\AppData\Local\Microsoft\Windows Terminal\settings.json" $DotfilesDir\windowsTerminalSettings.json
  Copy-Item "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" $DotfilesDir\windowsTerminalSettings.json
}

function Backup-GITConfig {
  Copy-Item $HOME/.gitconfig $DotfilesDir\.gitconfig__my
}

<#
 .Synopsis
  Copies public SSH key to remote server.

 .Parameter RemoteHost
  Remote host and user

 .Parameter KeyFile
  Public key local path

 .Parameter RemotePort
  Remote SSH port

 .Example
  Copy-SSHKey user@192.168.0.92
#>
function Copy-SSHKey {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [alias("h")]
    [string]
    $RemoteHost,

    [alias("k")]
    [string]
    $KeyFile = "$HOME/.ssh/id_rsa.pub",

    [alias("p")]
    [int]
    $RemotePort = 22
  )

  try {
    #    ssh $RemoteHost -p $RemotePort "mkdir ~/.ssh"
    ssh $RemoteHost -p $RemotePort "mkdir ~/.ssh; chmod 700 ~/.ssh; touch ~/.ssh/authorized_keys; chmod 600 ~/.ssh/authorized_keys; echo "$(Get-Content $KeyFile)" >> ~/.ssh/authorized_keys"
  }
  catch {
    Write-Error "Oh, error occurred:"
    Write-Error $_
    break
  }

  Write-Host "Succesfully copied!" -ForegroundColor green
}

<#
 .Synopsis
  Creates git repo and publish to GitHub

 .Description
  Creates git repo and publish to GitHub
  A GitHub repository must be created.

 .Parameter UseSSH
  Use SSH or HTTPS (boolean)

 .Parameter CustomName
  Custom GitHub repository name (if repo name is not directory name)

 .Example
  Publish-Project

 .Example
  Publish-Project -s 0 -r RepoNameWhatNotEqualsDirectoryName # Don't use SSH and use custom repo name
#>
function Publish-Project {
  [CmdletBinding()]
  param(
    [alias("s")]
    [boolean]
    $UseSSH = $True,

    [alias("r")]
    [string]
    $RepoName
  )

  if ($RepoName) {
    $DirectoryName = $RepoName
  }
  else {
    $DirectoryName = (Get-Item .).Name
  }

  $GithubUser = $(git config user.name)

  $HttpsRemote = "https://github.com/$GithubUser/$DirectoryName.git"
  $SSHRemote = "git@github.com:$GithubUser/$DirectoryName.git"

  if ($UseSSH) {
    $Remote = $SSHRemote
  }
  else {
    $Remote = $HttpsRemote
  }

  try {
    git init
    git add .
    git commit -m "Init commit"
    git branch -M main
    git remote add origin $Remote
    git push -u origin main
  }
  catch {
    Write-Host "Oh, error occurred:" -ForegroundColor red
    Write-Error $_
    break
  }

  Write-Host "Done!" -ForegroundColor green
}

<#
 .Synopsis
  Sets a static IP address for interface.

 .Parameter Interface
  Net interface name.
  Get it by `Get-NetIPAddress -AddressFamily IPv4 | Select-Object -Property InterfaceAlias,IPAddress`.

 .Parameter IPAddress
  New IP address.

 .Parameter DontConfigDNS
  If set, dont use current DNS in new settings.
  Useful if your goal is connecting 2 PCs with a wire to create a dumb LAN without access to Internet.
  Dont use if your goal is set static IP without loss access to Internet.

 .Example
  # Sets IP and save previous DNS settings
  Set-QuickIP -i "Ethernet" -ip 192.168.0.32

 .Example
  # Sets IP and disable DNS config
  Set-QuickIP -i "Ethernet" -ip 192.168.0.32 -DontConfigDNS
#>
function Set-QuickIP {
  [CmdletBinding()]
  param(
    [parameter(Mandatory = $true)]
    [alias("i")]
    [string]
    $Interface,

    [parameter(Mandatory = $true)]
    [alias("ip")]
    [ipaddress]
    $IPAddress,

    [switch]
    [alias("NoDns")]
    $DontConfigDNS = $False
  )

  try {
    $ipParams = @{
      InterfaceAlias = $Interface
      AddressFamily  = "IPv4"
      IPAddress      = $IPAddress
      PrefixLength   = 24
    }
    if (-not $DontConfigDNS) {
      $CurrentDNSServers = ((Get-NetIPConfiguration -InterfaceAlias Ethernet).DNSServer | Where-Object { $_.AddressFamily -eq 2 }).ServerAddresses
      $ipParams.DefaultGateway = (Get-NetIPConfiguration -InterfaceAlias Ethernet).IPv4DefaultGateway.NextHop
    }

    New-NetIPAddress @ipParams -ErrorAction Stop | Out-Null
    if (-not $DontConfigDNS) {
      Set-DnsClientServerAddress -InterfaceAlias $Interface -ServerAddresses $CurrentDNSServers -ErrorAction Stop | Out-Null
    }
    Restart-NetAdapter -InterfaceAlias $Interface -ErrorAction Stop | Out-Null
  }
  catch {
    Write-Error "Oh, error occurred:"
    Write-Error $_
    break
  }

  Write-Host "Succesfully configured!" -ForegroundColor green
}

<#
 .Synopsis
  Resets settings of interface to default (DHCP + automatic DNS configuration).

 .Parameter Interface
  Net interface name.
  Get it by `Get-NetIPAddress -AddressFamily IPv4 | Select-Object -Property InterfaceAlias,IPAddress`.

 .Example
  Reset-QuickIP -i "Ethernet"
#>
function Reset-QuickIP {
  [CmdletBinding()]
  param(
    [parameter(Mandatory = $true)]
    [alias("i")]
    [string]
    $Interface
  )

  try {
    $IPAddress = (Get-NetIPAddress -InterfaceAlias $Interface -AddressFamily IPv4).IPAddress
    $CurrentGateway = (Get-NetIPConfiguration -InterfaceAlias Ethernet).IPv4DefaultGateway.NextHop

    Remove-NetIPAddress -IPAddress $IPAddress -Confirm:$false -ErrorAction Stop | Out-Null
    Set-NetIPInterface -InterfaceAlias $Interface -Dhcp Enabled -ErrorAction Stop | Out-Null
    if ($CurrentGateway) {
      Remove-NetRoute -InterfaceAlias $Interface -NextHop $CurrentGateway -Confirm:$false -ErrorAction Stop | Out-Null
    }
    Set-DnsClientServerAddress -InterfaceAlias $Interface -ResetServerAddresses -ErrorAction Stop | Out-Null
    Restart-NetAdapter -InterfaceAlias $Interface -ErrorAction Stop | Out-Null
  }
  catch {
    Write-Error "Oh, error occurred:"
    Write-Error $_
    break
  }
  
  Write-Host "Succesfully resetted!" -ForegroundColor green
}

<#
 .Synopsis
  Checks new NodeJS versions.

 .Parameter CheckOnlyLTS
  Check only LTS or all versions.

 .Example
  Test-NodeJSVersion -lts 1 # Checks only LTS

 .Example
  Test-NodeJSVersion -lts 0 # Checks all versions
#>
function Test-NodeJSVersion {
  [CmdletBinding()]
  param(
    [alias("lts")]
    [boolean]
    $CheckOnlyLTS = $True
  )
  $NodeJSVersions = Invoke-RestMethod -Uri "https://nodejs.org/dist/index.json"
  $LatestVersion = ($CheckOnlyLTS ? $NodeJSVersions.Where({ $_.lts }) : $NodeJSVersions)[0].version
  $InstalledVersion = $(node -v)

  if ($NodeJSVersions -and $LatestVersion -and $InstalledVersion) {
    if ($InstalledVersion -ne $LatestVersion) {
      Write-Host -ForegroundColor green "Time to update Nodejs!"
      Write-Host -ForegroundColor blue "Current installed$($CheckOnlyLTS ? ' LTS ' : ' ')version: $(New-Text $InstalledVersion -ForegroundColor red)"
      Write-Host -ForegroundColor blue "New$($CheckOnlyLTS ? ' LTS ' : ' ')version: $(New-Text $LatestVersion -ForegroundColor green)"
      Write-Host -ForegroundColor blue "Info: You can use Volta, NVM, NVM Windows, n, asdf, etc. to update NodeJS."
    }
    else {
      Write-Host "You use latest$($CheckOnlyLTS ? ' LTS ' : ' ')NodeJS version!" -ForegroundColor green
    }
  }
}

function Backup-Path {
  $env:Path.Split(";") > $DotfilesDir\path.txt
}

function Backup-AlacrittyConfig {
  Copy-Item $HOME\AppData\Roaming\alacritty\alacritty.toml $DotfilesDir\alacritty.toml
}

function Backup-ConEmuConfig {
  Copy-Item $HOME\AppData\Roaming\ConEmu.xml $DotfilesDir\ConEmu.xml
}

function Backup-ScoopList {
  scoop export > $DotfilesDir\scoopPackages.txt
}

function Backup-AllConfigsAAA {
  Backup-PSProfile
  Backup-AHKScripts
  Backup-WinFetchConfig
  Backup-WindowsTerminalConfig
  Backup-GITConfig
  Backup-Path
  Backup-AlacrittyConfig
  Backup-ConEmuConfig
  Backup-ScoopList
}

function Start-MyWSLAlpine {
  C:\Arch\Arch.exe
}

function Stop-MyWSLAlpine {
  wsl --shutdown
}

function Quick-MyWSLAlpine {
  Start-MyWSLAlpine
  Stop-MyWSLAlpine
}
