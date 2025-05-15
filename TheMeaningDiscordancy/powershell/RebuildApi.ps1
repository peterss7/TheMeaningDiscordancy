$RootPath = Resolve-Path "$PSScriptRoot\.."
$composeFile = "$RootPath\docker-compose.yml"
. "$PSScriptRoot\Logger.ps1"
$envPath = "$RootPath\.env"

if (Test-Path $envPath) {
    Get-Content $envPath | ForEach-Object {
        if ($_ -match "^\s*([^#][^=]*)=(.*)$") {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()
            [System.Environment]::SetEnvironmentVariable($key, $value)
        }
    }
}
else {
    Log-Error "'.env' file not found at $envPath"
    exit 1
}

# Set variables from environment
$imageName = $env:IMAGE_NAME
$containerName = $env:CONTAINER_NAME

# Stop and remove existing container if it exists
if (docker ps -a --format '{{.Names}}' | Where-Object { $_ -eq $containerName }) {
    Log-Info "Stopping and removing existing container..."
    docker-compose -f $composeFile down
}

# Rebuild image
Log-Info "Rebuilding Docker image: $imageName..."
docker-compose -f $composeFile up

if ($LASTEXITCODE -ne 0) {
    Log-Error "Docker build failed."
    exit 1
}

Log-Info "Container is running! Access Swagger at: http://localhost:7106/swagger"