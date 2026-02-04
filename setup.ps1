$IsAdmin = (new-object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole("Administrators")

if ($IsAdmin) {
	throw "Do not run as admin."
}

if ($PSVersionTable.PSVersion.Major -lt 7) {
	throw "Must use PowerShell 7+."
}

if (-not (Get-Module -Name psake -ListAvailable)) {
	$command = @(
		"-Command",
		"Install-Module",
		"-Name",
		"psake",
		"-Scope",
		"AllUsers",
		"-AcceptLicense"
	)
	Start-Process -Wait -Passthru -Verb runas -FilePath "pwsh" -WorkingDirectory . -ArgumentList $command
}

Invoke-Psake .\setup\psakefile.ps1
