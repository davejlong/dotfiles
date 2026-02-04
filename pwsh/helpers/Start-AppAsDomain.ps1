<#
.DESCRIPTION
Runs an application under domain credentials

.PARAM Username
Domain user to run app as (ie. CONTOSO\dlong)

.PARAM Path
Path to the executable

.EXAMPLE
> Start-AppAsDomain -Username CONTOSO\dlong -Path mmc.exe
> # Runs mmc as the domain user
#>
function Start-AppAsDomain {
  [CmdletBinding()]
  param(
    [String]$Username,
    [String]$Path
  )

  $Pro = @{
    Path = "runas.exe"
    PassThru = $true
    Wait = $true
    ArgumentList = @(
      "/user:$Username"
      "/netonly"
      "$Path"
    )
  }
  Start-Process @Pro
}
