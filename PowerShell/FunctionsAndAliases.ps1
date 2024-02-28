# miniserve function
function s {
  [CmdletBinding()]
  param([string]$path = ".", [int]$p = 3000, [string]$ip, [switch]$qr, [switch]$s)

  $argsList = [System.Collections.ArrayList]@()

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
  eza -Flah -s type --group-directories-first $args
}

function t {
  #lsd -a --tree -I "{node_modules,.git}" --group-directories-first $args
  eza -Flah -s type --group-directories-first --tree --ignore-glob ".git|node_modules|.parcel-cache|.cache" $args
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
  $items = Get-Item -Path "C:\Users\ivan\Documents\PowerShell\*" -Exclude ("Help")

  Remove-Item -Recurse -Force "E:\files\a_important\PROGRAMS\PowerShell"

  foreach ($item in $items) { Copy-Item $item.FullName -Destination "E:\files\a_important\PROGRAMS\PowerShell$($item.PSIsContainer ? "\$($item.Name)" : '')" -Recurse -Force }

  Get-ChildItem C:\Users\ivan\Documents\PowerShell\Modules > E:\files\a_important\PROGRAMS\pwsh_modules.txt
}

function Backup-AHKScripts {
  Remove-Item -Recurse -Force "E:\files\a_important\PROGRAMS\AutoHotkey"

  Copy-Item "C:\Users\ivan\Documents\AutoHotkey" -Destination "E:\files\a_important\PROGRAMS\AutoHotkey" -Recurse -Force
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

  echo $code | python
}

function subl {
  & "C:\\Program Files\\Sublime Text\\sublime_text.exe" $args
}

function ff {
  fastfetch --file "E:\files\a_important\PROGRAMS\FETCH_LOGO.txt" --structure Title:Separator:OS:Host:Uptime:Packages:Shell:Monitor:Terminal:TerminalFont:CPU:GPU:Memory:Version:Break:Colors $args
}

function e {
  explorer $PWD $args
}

function dy {
  $input | yt-dlp --compat-option filename-sanitization $args
}

function tc {
  & "C:\\Program Files\\totalcmd\\TOTALCMD64.EXE" \L $PWD $args
}

function far {
  & "c:\\Program Files\\Far Manager\\Far.exe" $PWD $args
}

function dns {
  $input | dog -n 192.168.0.1 $args
}
