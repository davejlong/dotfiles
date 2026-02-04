Include "./helpers.ps1"

Task envvars {
	[System.Environment]::SetEnvironmentVariable("DotfilesPath", "$DotfilesPath", "User")
	$env:DotfilesPath = "$DotfilesPath"
}

Task all {
  Invoke-psake -buildFile "$DotfilesPath/winget/psakefile.ps1"

  $BuildFiles = Get-ChildItem -Path "$DotfilesPath" -Filter psakefile.ps1 -Recurse | `
    Where-Object { (Split-Path $_.Directory -Leaf) -notin @("setup", "winget") }

  foreach($BuildFile in $BuildFiles) {
    Invoke-Psake -BuildFile $BuildFile
  }
}

Task default -Depends envvars, all
