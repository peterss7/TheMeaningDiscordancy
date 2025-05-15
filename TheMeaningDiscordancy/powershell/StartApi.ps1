$RootPath = Resolve-Path "$PSScriptRoot\.."
$composeFile = "$RootPath\docker-compose.yml"
. "$PSScriptRoot\Logger.ps1"
$envFile = "$RootPath\.env"

if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match "^\s*([^#][^=]*)=(.*)$") {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()
            [System.Environment]::SetEnvironmentVariable($key, $value)
        }
    }
}
else {
    Log-Error "'.env' file not found."
    exit 1
}

Log-Info "Loaded configuration:"
Log-Info "IMAGE_NAME: $env:IMAGE_NAME"
Log-Info "CONTAINER_NAME: $env:CONTAINER_NAME"
Log-Info "ENVIRONMENT: $env:ASPNETCORE_ENVIRONMENT"

$containerName = $env:CONTAINER_NAME

# Remove existing container
if (docker ps -a --format '{{.Names}}' | Where-Object { $_ -eq $containerName }) {
    Log-Info "Stopping and removing existing container..."
    docker-compose --env-file $env-file -f $composeFile down 
}

# Build the Docker image
Log-Info "Building Docker image..."
docker-compose -f $composeFile up --build -d
if ($LASTEXITCODE -ne 0) {
    Log-Error "Docker build failed."
    exit 1
}

Log-Info "Application is running. Access Swagger at: http://localhost:7106/swagger"
