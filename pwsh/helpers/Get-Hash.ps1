function Get-Hash {
  <#
  .SYNOPSIS
  Gets the hash respresentation of a string.

  .PARAMETER String
  The string to hash

  .PARAMETER Algorithm
  Specifies the hash algorithm to use when calculating the file hash.

  This parameter supports the same algorithms as Get-FileHash, such as:
  SHA1, SHA256, SHA384, SHA512, and MD5
  #>

  [CmdletBinding()]
  param(
    [Parameter(Mandatory, Position=0)]
    [string] $String,
    [Parameter(Position=1)]
    [ValidateSet("sha1", "sha256", "sha384", "sha512", "md5")]
    [String] $Algorithm="sha256"
  )

  $StringStream = [IO.MemoryStream]::new([byte[]][char[]]$String)
  $Hash = Get-FileHash -InputStream $StringStream -Algorithm $Algorithm
  $Hash.Hash
}
