function Invoke-Wget {
  <#
  .DESCRIPTION
  Downloads a file from a URL using syntax similar to the wget command
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory, Position = 0)]
    [String] $URI,
    [Parameter(Position = 1)]
    [String] $OutputPath
  )

  if (!$OutputPath) {
    Write-Debug "Getting OutputPath from URI"
    $OutputPath = Split-Path -Leaf $URI
  }

  Invoke-WebRequest -Uri $URI -OutFile $OutputPath
}

New-Alias -Name wget -Value Invoke-Wget
