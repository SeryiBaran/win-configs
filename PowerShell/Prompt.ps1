if ($PromptProgram -eq "posh") {
  posh-windows-amd64 init pwsh --config 'C:\pathTools\omp.json' | Invoke-Expression
}
elseif ($PromptProgram -eq "starship") {
  Invoke-Expression (&starship init powershell)

  function Invoke-Starship-PreCommand {
    $loc = $executionContext.SessionState.Path.CurrentLocation;
    $prompt = "$([char]27)]9;12$([char]7)"
    if ($loc.Provider.Name -eq "FileSystem") {
      $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
    }
    $host.ui.Write($prompt)
  }
}
elseif ($PromptProgram -eq "my") {
  $env:VIRTUAL_ENV_DISABLE_PROMPT = 1

  function prompt {
    $status = $?
    $statusColor = $status -eq $True ? "blue" : "red"

    $commandDurationBlock = if ($previousCommand = Get-History -Count 1) {
      ' {0:N2}s' -f ($previousCommand.EndExecutionTime - $previousCommand.StartExecutionTime).TotalSeconds
    }

    $loc = $executionContext.SessionState.Path.CurrentLocation;
    $prompt = "$([char]27)]9;12$([char]7)"
    if ($loc.Provider.Name -eq "FileSystem") {
      $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
    }
    $host.ui.Write($prompt)

    $CurrentLocationPath = $executionContext.SessionState.Path.CurrentLocation.Path
    $path = switch -Wildcard ($CurrentLocationPath) {
      "$HOME" { "~" }
      "$HOME\*" { $CurrentLocationPath.Replace($HOME, "~") }
      default { $CurrentLocationPath }
    }

    $CurrentLocationPathHasGit = Test-Path $CurrentLocationPath\.git

    $body = @"

$(Text $Env:UserName -Fg red) $(Text $path -Fg green)$($CurrentLocationPathHasGit ? (Text " (git)" -Fg yellow) : "")$commandDurationBlock
$($env:VIRTUAL_ENV ? "$(Text "($(Split-Path $env:VIRTUAL_ENV -Leaf))" -Fg green) " : "")$(Text '$' -Fg $statusColor) 
"@

    $body
  }
}
