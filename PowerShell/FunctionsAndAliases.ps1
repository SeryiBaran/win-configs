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
  qrrs $args
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

  Remove-Item -Recurse -Force "E:\files\A.ВАЖНЫЕ\PROGRAMS\PowerShell"

  foreach ($item in $items) { Copy-Item $item.FullName -Destination "E:\files\A.ВАЖНЫЕ\PROGRAMS\PowerShell$($item.PSIsContainer ? "\$($item.Name)" : '')" -Recurse -Force }

  Get-Module > E:\files\A.ВАЖНЫЕ\PROGRAMS\pwsh_modules.txt && (Get-Module).name >> E:\files\A.ВАЖНЫЕ\PROGRAMS\pwsh_modules.txt
}

function Backup-AHKScripts {
  Remove-Item -Recurse -Force "E:\files\A.ВАЖНЫЕ\PROGRAMS\AutoHotkey"

  Copy-Item "C:\Users\ivan\Documents\AutoHotkey" -Destination "E:\files\A.ВАЖНЫЕ\PROGRAMS\AutoHotkey" -Recurse -Force
}

function Get-IP {
  [CmdletBinding()]
  param(
    [alias("i")]
    [string]
    $Interface
  )

  $args = @{
    AddressFamily = "IPv4"
  }

  if ($Interface) {
    $args.InterfaceAlias = $Interface
  }

  Get-NetIPAddress @args | Select-Object -Property InterfaceAlias, IPAddress
}

function tb {
  $input | nc termbin.com 9999
}

function word {
  & "C:\Program Files\Microsoft Office\Office16\WINWORD.EXE" $args
}

function excel {
  & "C:\Program Files\Microsoft Office\Office16\EXCEL.EXE" $args
}

function qalc {
  chcp 866
  & "C:\Program Files\Qalculate\qalc.exe" $args
  chcp 65001
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

function e {
  explorer $args
}
