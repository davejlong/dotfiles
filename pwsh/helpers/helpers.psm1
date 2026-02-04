$Helpers = Get-ChildItem -Path "$PSScriptRoot" -Filter "*.ps1"
foreach ($Import in $Helpers) {
  try {
    . $Import.FullName
  } catch {
    Write-Error -Message "Failed to import function $($Import.FullName): $_"
  }
}

Export-ModuleMember -Function $Helpers.BaseName -Alias *

