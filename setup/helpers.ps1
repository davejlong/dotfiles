properties {
	$DotfilesPath = Split-Path -Path $PSScriptRoot -Parent
}

function Invoke-TaskAsAdmin($BuildFile, $TaskName) {
  $command = @(
    "-Command",
    "Invoke-psake",
    "-buildFile", "$BuildFile",
    "-taskList", "$TaskName"
  )
  Start-Process -Wait -Passthru -Verb runas -FilePath "pwsh" -WorkingDirectory . -ArgumentList $command
}

function Test-IsAdmin() {
	$Identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
	$Principal = (New-Object System.Security.Principal.WindowsPrincipal($Identity))
	$Principal.IsInRole("Administrators")
}


function Test-ModuleInstalled($Name) {
	$Module = Get-Module -Name $Name -ListAvailable
	return [bool]$Module
}

function New-Hardlink($LinkPath, $TargetPath) {
	$Link = Resolve-Path $LinkPath
	$Target = Resolve-Path $TargetPath

	if (Test-Path -Path $Link) {
		$FileName = Split-Path $Link -Leaf
		Rename-Item $Link -NewName "$FileName.orig"
	}

	Exec { cmd /c mklink /H "$($Link.Path)" "$($Target.Path)" }
}

function New-StartupShortcut($TagetPath) {
	$Startup = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Startup"

	$WshShell = New-Object -ComObject WScript.Shell

	$Shortcut = $WshShell.CreateShortcut("$Startup\$($TargetPath.Name).lnk")
	$Shortcut.TargetPath = $TargetPath.FullName
	$Shortcut.Save()
}
