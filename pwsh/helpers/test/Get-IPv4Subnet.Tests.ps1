. $PSScriptRoot/../Get-IPv4Subnet.ps1

Describe 'Test-IPv4Subnet' {
  It 'returns false when not given a CIDR subnet' {
    Test-IPv4Subnet -Subnet "192.168.1.0" | Should -BeFalse
  }
}
