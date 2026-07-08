<#
.DESCRIPTION
Takes an IPv4 subnet in CIDR format and calculates various properties about the subnet

.PARAMETER Subnet
IPv4 CIDR string to calculate from. Can be in the format 192.168.1.0/24 or 192.168.1.0/255.255.255.0
#>
function Get-IPv4Subnet {
  [CmdletBinding()]
  param (
    [Parameter()]
    [String] $Subnet
  )



}

<#
.DESCRIPTION
Tests that the subnet is a valid CIDR subnet#>
function Test-IPv4Subnet {
  [CmdletBinding()]
  param (
    [Parameter()]
    [String] $CIDRAddress
  )
  $CIDRParts = $CIDRAddress -split "/"
  # Make sure the subnet contains both an IP address and subnet
  if ($CIDRParts.Length -ne 2) {
    Write-Debug "CIDR Address is an invalid format"
    return $false
  }

  $IPAddress, $Subnet = $CIDRParts

  # Test that the IP address is valid
  try {
    $IPAddress = [ipaddress]$IPAddress
  } catch {
    Write-Debug "IP Address is not valid."
    return $false
  }

  # Test the subnet
}
