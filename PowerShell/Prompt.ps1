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
  function prompt {
    $status = $?
    $statusColor = $status -eq $True ? "blue" : "red"

    $loc = $executionContext.SessionState.Path.CurrentLocation;
    $prompt = "$([char]27)]9;12$([char]7)"
    if ($loc.Provider.Name -eq "FileSystem") {
      $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
    }
    $host.ui.Write($prompt)

    # $path = $executionContext.SessionState.Path.CurrentLocation.Path
    $path = switch -Wildcard ($executionContext.SessionState.Path.CurrentLocation.Path) {
      "$HOME" { "~" }
      "$HOME\*" { $executionContext.SessionState.Path.CurrentLocation.Path.Replace($HOME, "~") }
      default { $executionContext.SessionState.Path.CurrentLocation.Path }
    }

    $body = @"

$(Text $Env:UserName -Fg red) $(Text $path -Fg green)
$(Text '$' -Fg $statusColor) 
"@

    $body
  }
}
