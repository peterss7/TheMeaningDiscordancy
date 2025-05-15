# get and verify env variables
$envFilePath = "./"
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
    Write-Error "'.env' file not found."
    exit 1
}

# Set strings
$imageName = $env:IMAGE_NAME
$containerName = $env:CONTAINER_NAME
$aspnetEnv = $env:ASPNETCORE_ENVIRONMENT
$dbConn = $env:DB_CONNECTION_STRING
$contextPath = "."
$dockerFilePath = "docker/api/Dockerfile"

# Remove existing container
if (docker ps -a --format '{{.Names}}' | Where-Object { $_ -eq $containerName }) {
    Write-Host "Stopping and removing existing container..."
    docker stop $containerName | Out-Null
    docker rm $containerName | Out-Null
}

# Build the Docker image
Write-Host "Building Docker image..."
docker build -t $imageName -f $dockerFilePath $contextPath
if ($LASTEXITCODE -ne 0) {
    Write-Error "Docker build failed."
    exit 1
}


# Run container
Write-Host "Running container..."
docker run -d -p 7106:80 --name $containerName `
    -e "ASPNETCORE_ENVIRONMENT=$aspnetEnv" `
    -e "ConnectionStrings__DefaultConnection=$dbConn" `
    $imageName
