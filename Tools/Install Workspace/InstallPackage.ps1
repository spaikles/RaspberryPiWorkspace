Write-Output "Installing Worspace"

$InstallManifest = Get-Content $PSScriptRoot\RaspberryPiInstallManifest.json | ConvertFrom-Json