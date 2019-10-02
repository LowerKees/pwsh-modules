# Create a module manifest
New-ModuleManifest `
    -Path "$PSSCriptRoot\ReleaseIt\ReleaseIt.psd1" `
    -Author "Martijn Beenker" `
    -Description "Build, release and password rotation functions" `
    -FunctionsToExport @('Get-Artifacts','New-Deployment','New-Passwords')

# Find the module path
$Env:PSModulePath

# Login as admin
$Dest = "C:\Users\martijn.beenker\Documents\WindowsPowerShell\Modules" 
$DestDir = "$($Dest)\ReleaseIt"
if (Test-Path $DestDir) { Remove-Item $DestDir -Recurse }

Copy-Item `
    "$($PSScriptRoot)\ReleaseIt" `
    -Recurse `
    -Destination $Dest

# Check result
Get-ChildItem `
    -Path $Dest `
    -Filter "ReleaseIt.psm1" `
    -Recurse
