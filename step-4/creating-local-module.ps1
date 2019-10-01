# Find the module path
$Env:PSModulePath

# Login as admin
$Dest = "C:\Users\M64A610\Onedrive - NN\Documents\WindowsPowerShell\Modules\" 
$DestDir = "$($Dest)\ReleaseIt"
if (Test-Path $DestDir) { Remove-Item $DestDir -Force }

Copy-Item `
    "$($PSScriptRoot)\ReleaseIt" `
    -Recurse `
    -Destination $Dest

# Check result
Get-ChildItem `
    -Path $Dest `
    -Filter "ReleaseIt.psm1" `
    -Recurse
