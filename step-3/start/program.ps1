Import-Module "$($PSScriptRoot)\ReleaseIt"

Get-Artifacts
New-Deployment
New-Passwords