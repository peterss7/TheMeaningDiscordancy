# Path to env file
$envFilePath = ".env"
if (Test-Path $envFilePath) {
    Get-Content $envFilePath | ForEach-Object {
        if ($_ -match "^\s*([^#][^=]*)=(.*)$") {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()
            [System.Environment]::SetEnvironmentVariable($key, $value)
        }
    }
}
else {
    Write-Error "'.env' file not found at $envFilePath"
    exit 1
}

# Set variables from environment
$imageName = $env:IMAGE_NAME
$containerName = $env:CONTAINER_NAME

# Stop and remove existing container if it exists
if (docker ps -a --format '{{.Names}}' | Where-Object { $_ -eq $containerName }) {
    Write-Host "Stopping and removing existing container..."
    docker-compose down
}

# Rebuild image
Write-Host "`nRebuilding Docker image: $imageName..."
docker-compose up

if ($LASTEXITCODE -ne 0) {
    Write-Error "Docker build failed."
    exit 1
}

Write-Host "`n🚀 Container is running! Access Swagger at: http://localhost:7106/swagger"