Include ../setup/helpers.ps1

Properties {

}

Task extensions -PreCondition { Get-Command "code" } {
  $Extensions = (Get-Content extensions.txt) -match "^[A-Za-z]"

  foreach ($Extension in $Extensions) {
    Exec { code --install-extension $Extension --force }
  }
}

Task default -Depends extensions
