$env:STARSHIP_CONFIG = "$PSScriptRoot/starship/starship.toml"
Invoke-Expression (&starship init powershell)

# PowerToys Command Not Found
if (Get-Module -ListAvailable -Name Microsoft.WinGet.CommandNotFound) {
  Import-Module -Name Microsoft.WinGet.CommandNotFound
}

if (Get-Module -ListAvailable -Name gsudoModule) {
  Import-Module -Name gsudoModule
}

Import-Module "$PSScriptRoot/helpers/Helpers.psm1"
