function Test-FileHash {
  <#
    .SYNOPSIS
      Tests a file hash against a known checksum or validates files from a checksum list.

    .DESCRIPTION
      The Test-FileHash command calculates the hash of a file and compares it to an expected checksum.

      You can use this command in one of two ways:

      1. Provide the path to a single file and a known checksum using the Path and Checksum parameters.
      2. Provide the path to a checksum file containing checksums and file paths to validate multiple files.

      The Algorithm parameter specifies which hashing algorithm to use. It supports the same algorithms as Get-FileHash.

    .PARAMETER Path
      Specifies the path to either:

      - A single file to hash and test against a known checksum
      - A checksum file containing a list of checksums and associated file paths

      When Path points to a single file, the Checksum parameter must also be provided.

    .PARAMETER Checksum
      Specifies the expected checksum value for the file identified by Path.

      Use this parameter only when Path points to a single file that should be tested against a known hash.

    .PARAMETER Algorithm
      Specifies the hash algorithm to use when calculating the file hash.

      This parameter supports the same algorithms as Get-FileHash, such as:
      SHA1, SHA256, SHA384, SHA512, and MD5

    .EXAMPLE
      > Test-FileHash -Path 'C:\Installers\AppSetup.exe' -Checksum 'A1B2C3D4E5F67890123456789ABCDEF0123456789ABCDEF0123456789ABCDEF' -Algorithm SHA256

      Calculates the SHA256 hash of AppSetup.exe and compares it to the provided checksum.

    .EXAMPLE
      > Test-FileHash -Path 'C:\Checksums\sha256sums.txt' -Algorithm SHA256

      Validates files listed in sha256sums.txt using the SHA256 algorithm.

    .NOTES
      The format of the checksum file is determined by the implementation of Test-FileHash.
      Ensure that the checksum list matches the selected algorithm and that referenced file paths are accessible.

      The Algorithm parameter should use a value supported by Get-FileHash.

    .LINK
      Get-FileHash
  #>
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, Position=0)]
    [String] $Path,
    [Parameter(Position=1)]
    [String] $Checksum,
    [Parameter()]
    [ValidateSet("sha1", "sha256", "sha384", "sha512", "md5")]
    [String] $Algorithm="sha256"
  )

  $Checksums = @()

  if (-not $Checksum) {
    # Assume that $Path contains a checksum path which contains filenames and their checksum
    $Checksums = Get-Content -Path $Path | ForEach-Object {
      $Line = $_ -split "  "
      return [PSCustomObject]@{
        Hash = $Line[0]
        Path = $Line[1]
        Pass = $false
      }
    }
  } else {
    $Checksums = @([PSCustomObject]@{
      Hash = $Checksum
      Path = $Path
      Pass = $false
    })
  }

  foreach($Check in $Checksums) {
    $FileHash = Get-FileHash -Path $Check.Path -Algorithm $Algorithm
    if ($FileHash.Hash -eq $Check.Hash) {
      Write-Host "Checksum passed: $($Check.Path). Hash: $($FileHash.Hash)"
      $Check.Pass = $true
    } else {
      Write-Host "Checksum failed: $($Check.Path). Expected: $($Check.Hash). Actual: $($FileHash.Hash)"
    }
  }

  return $Checksums.Pass -notcontains $false
}
