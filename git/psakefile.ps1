Include ../setup/helpers.ps1

Properties {
  $ConfigFile = "$HOME/.gitconfig"
}

Task install -Precondition { -not ((Get-Content -Path $ConfigFile -ErrorAction SilentlyContinue) -match "path = .*\/git\/gitconfig") } {
  $GitConfig = @"
[include]
  path = $($DotfilesPath -replace '\\', '/')/git/gitconfig
"@

  Add-Content -Path "$HOME/.gitconfig" -Value $GitConfig
}

Task default -Depends install
