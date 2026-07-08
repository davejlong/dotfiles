function dig {
  [CmdletBinding()]
  param (
      [Parameter()]
      [string] $Hostname,
      [Parameter()]
      [Microsoft.DnsClient.Commands.RecordType] $Type="ANY",
      [Parameter()]
      [string] $Server
  )

  $Type
}
