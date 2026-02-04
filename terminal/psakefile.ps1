Include "../setup/helpers.ps1"

properties {
  $FontUri = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"
  $FontName = "FiraCode"
	$TerminalDir = "$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
}

Task config {
	if (-not (Test-IsAdmin)) {
		Invoke-TaskAsAdmin -BuildFile $psake.build_script_file -TaskName "config"
		return
	}
	New-Hardlink -LinkPath "$TerminalDir/settings.json" -TargetPath "$DotfilesPath/terminal/settings.json"
}

Task font {
  $FontZip = Join-Path $env:TEMP "$FontName.zip"
  $FontDir = Join-Path $env:TEMP "$FontName"

  Invoke-WebRequest -Uri $FontUri -OutFile $FontZip
  Expand-Archive -Path $FontZip -DestinationPath $FontDir -Force
  
  $LocalUserFontDir = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Fonts"
  $LocalUserFontReg = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

  if (-not (Test-Path $LocalUserFontDir)) {
    New-Item -Path $LocalUserFontDir -ItemType Directory
  }

  # $Font = "FiraCodeNerdFontMono-Regular.ttf"
  $FontFile = "FiraCodeNerdFontMono-Medium.ttf"
  $FontName = "FiraCode Nerd Font Mono Med (TrueType)"
  Copy-Item -Path "$FontDir/$FontFile" -Destination $LocalUserFontDir
  Set-ItemProperty -Path $LocalUserFontReg -Name "$FontName" -Value "$LocalUserFontDir\$FontFile"

  Remove-Item -Recurse $FontDir
  Remove-Item $FontZip
}

Task default -Depends config
