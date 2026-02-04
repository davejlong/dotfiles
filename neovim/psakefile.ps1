Include ../setup/helpers.ps1

Properties {
	$ConfigDir = "$env:LOCALAPPDATA/nvim"
	$ConfigFile = "$ConfigDir/init.lua"
	$AutoloadDir = "$ConfigDir/autoload"
	$PlugFile = "$ConfigDir/autoload/plug.vim"
	$PlugUri = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
}

Task config -Precondition {
  -not ((Get-Content -Path "$ConfigFile" -ErrorAction Continue) -match "DotfilesPath")
} {
	if (-not (Test-Path $ConfigDir)) {
		New-Item -Path $ConfigDir -ItemType Directory
	}
	$ConfigLoader = Get-Content -Path "install.lua"
	if (-not (Test-Path $ConfigFile)) {
	# if (-not ((Get-Content $ConfigFile) -contains $ConfigLoader)) {
		Add-Content $ConfigFile -Value $ConfigLoader
	}
}

Task install -Precondition {-not (Test-Path $PlugFile) } {
	if (-not (Test-Path $AutoloadDir)) {
		New-Item -Path $AutoloadDir -ItemType Directory
	}

	Invoke-WebRequest -Uri "$PlugUri" -OutFile "$PlugFile"
}

Task plugins {
	Exec { nvim --headless -c 'PlugInstall' -c 'q' -c 'q' }
}


Task default -Depends config, install, plugins
