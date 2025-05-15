# path of compose file
$composeFile = "docker-compose.yml"

if (-not (Test-Path $composeFile)) {
    Write-Error "Cannot find $composeFile in the current directory."
    exit 1
}

Write-Host "⛔ Stopping containers defined in $composeFile..."

# Stopping containers
docker-compose -f $composeFile down

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ All containers stopped and removed."
}
else {
    Write-Error "Something went wrong stopping the containers."
}
