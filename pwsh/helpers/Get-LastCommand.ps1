<#
.DESCRIPTION
Get's the last command that was run

.EXAMPLE
> Get-NetNeighbor 192.168.1.1
> (Get-LastCommand).LinkLayerAddress -replace "-", ":"
> # 00:00:00:00:00:00
#>
function Get-LastCommand {
  [alias("glc")]

  $Command = $null
  $i = 0
  do {
    $Command = Get-History | Select-Object -Last 1 -Skip $i -ExpandProperty CommandLine
    $i++
  } while ($Command -in @("Get-LastCommand", "glc") -and $Command)

  if($Command) {
    Write-Debug "Executing: $Command"
    Invoke-Expression $Command
  } else {
    throw "Failed to find command in history"
  }
}

Set-Alias -Name glc -Value Get-LastCommand
