function Get-CurrentWeather {
  [CmdletBinding()]
  param (
    [String] $Locale="HVN",
    [String] $ViewOptions="1"
  )

  Invoke-RestMethod -Uri "http://wttr.in/$($Locale)?$($ViewOptions)"
}
