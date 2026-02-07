Include ../setup/helpers.ps1

Properties {

}

Task choco {
  if (-not (Test-IsAdmin)) {
    return Invoke-TaskAsAdmin -BuildFile $psake.build_script_file -TaskName "choco"
  }

	$Apps = (Get-Content "./choco-apps.txt") -match "^[A-Za-z]"

	foreach($App in $Apps) {
    Exec { choco upgrade --install-if-not-installed --yes --accept-license $App }
	}
}

Task features {
  if (-not (Test-IsAdmin)) {
    Invoke-TaskAsAdmin -BuildFile $psake.build_script_file -TaskName "features"
    return
  }

  $Features = (Get-Content "features.txt") -match "^[A-Za-z]"
  $RestartNeeded = $false
  foreach ($Feature in $Features) {
    $InstallStatus = Enable-windowsOptionalFeature -FeatureName $Feature -Online -All -NoRestart
    $RestartNeeded = $RestartNeeded -or $InstallStatus.RestartNeeded
  }

  if ($RestartNeeded) { Write-Host "[Windows Features] Restart needed after installing features" }
}

Task wingetmodule -PreCondition { (-not (Test-ModuleInstalled -Name "Microsoft.WinGet.Client")) } {
	if (-not (Test-IsAdmin)) {
		Invoke-TaskAsAdmin -BuildFile $psake.build_script_file -TaskName "psmodule"
		return
	}
  
	$PSModule = Get-Module -Name Microsoft.WinGet.Client -ListAvailable
	if (-not $PSModule) {
		Install-Module -Name Microsoft.WinGet.Client -Scope AllUsers
	}
}

Task winget -Depends wingetmodule {
	Import-Module Microsoft.WinGet.Client
	$Apps = (Get-Content "./winget-apps.txt") -match "^[A-Za-z]"

	foreach($App in $Apps) {
    Write-Host "$App"
		if (Get-WinGetPackage -Id $App) {
			Write-Output "$App already installed. Attempting to update."
			Update-WinGetPackage -Id $App
		} else {
			Write-Output "Installing $App"
			Install-WinGetPackage -Id $App
		}
	}
}

Task default -Depends features, winget
