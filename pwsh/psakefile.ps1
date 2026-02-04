Include ../setup/helpers.ps1

Properties {
  $ProfilePaths = @(
    "PowerShell\Microsoft.VSCode_profile.ps1",
    "PowerShell\Microsoft.PowerShell_profile.ps1",
    "WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
  )
}

Task modules {
	if (-not (Test-IsAdmin)) {
		Invoke-TaskAsAdmin -BuildFile $psake.build_script_file -TaskName "modules"
		return
	}
  
  $Modules = (Get-Content "modules.txt") -match "^[A-Za-z]"

  Install-Module -Name $Modules -Scope AllUsers -AcceptLicense
}

Task config {
  $Documents = [System.Environment]::GetFolderPath("MyDocuments")
  $IncludePath = Get-Item "$DotfilesPath\pwsh\profile.ps1"

  $IncludeString = @"
. `$env:DotfilesPath/pwsh/profile.ps1
"@

  foreach($ProfilePath in $ProfilePaths) {
    $FullProfile = Join-Path $Documents $ProfilePath
    # Ensure profile directory exists
    if (-not (Test-Path (Split-Path "$FullProfile" -Parent))) {
      New-Item -Path (Split-Path $FullProfile -Parent) -ItemType Directory
    }
    Add-Content $FullProfile -Value $IncludeString
  }
}

Task default -Depends modules, config
