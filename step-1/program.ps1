function Sleep-WithGraphics {
    foreach($x in 1..3) {
        Start-Sleep -Seconds 1
        Write-Host "..."
    }

}
function Get-Artifacts {
    Write-Host "Getting artifacts from artifact staging dir..." -ForegroundColor DarkBlue
    Sleep-WithGraphics
    Write-Host "Successfully retrieved artifacts" -ForegroundColor Green
}

function New-Deployment{
    Write-Host "Starting deployment of solution to environment" -ForegroundColor DarkBlue
    Sleep-WithGraphics
    Write-Host "Successfully deployed solution to environment" -ForegroundColor Green
}

function New-Passwords {
    Write-Host "Starting password rotation on solution components" -ForegroundColor DarkBlue
    Sleep-WithGraphics
    Write-Host "Successfully rotated solution passwords" -ForegroundColor Green
}

Get-Artifacts
New-Deployment
New-Passwords