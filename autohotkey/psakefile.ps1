Include ../setup/helpers.ps1

Task install {
	$ahkScripts = Get-ChildItem -Path (Split-Path $psake.build_script_file -Parent) -Filter *.ahk

	Write-Host $ahkScripts
	foreach($ahkScript in $ahkScripts) {
		New-StartupShortcut -TargetPath $ahkScript
	}

}

Task default -Depends install
