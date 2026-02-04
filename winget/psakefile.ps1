Include ../setup/helpers.ps1

Task psmodule -PreCondition { (-not (Test-ModuleInstalled -Name "Microsoft.WinGet.Client")) } {
	if (-not (Test-IsAdmin)) {
		Invoke-TaskAsAdmin -BuildFile $psake.build_script_file -TaskName "psmodule"
		return
	}
  
	$PSModule = Get-Module -Name Microsoft.WinGet.Client -ListAvailable
	if (-not $PSModule) {
		Install-Module -Name Microsoft.WinGet.Client -Scope AllUsers
	}
}

Task install -Depends psmodule {
	Import-Module Microsoft.WinGet.Client
	$Apps = (Get-Content "./apps.txt") -match "^[A-Za-z]"

	foreach($App in $Apps) {
		if (Get-WinGetPackage -Id $App) {
			Write-Output "$App already installed. Attempting to update."
			Update-WinGetPackage -Id $App
		} else {
			Write-Output "Installing $App"
			Install-WinGetPackage -Id $App
		}
	}
}

Task default -Depends install
