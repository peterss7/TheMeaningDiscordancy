$RootPath = Resolve-Path "$PSScriptRoot\.."
$composeFile = "$RootPath\docker-compose.yml"
. "$PSScriptRoot\Logger.ps1"
$envFile = "$RootPath\.env"

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

if (-not (Test-Path $composeFile)) {
    Log-Fail "Cannot find $composeFile in the current directory."
    exit 1
}

Log-Stop "Stopping containers defined in $composeFile..."
Log-Info "RootPath: $RootPath`ncomposeFile: $composeFile"

# Stopping containers
docker-compose --env-file $envFile -f $composeFile down

if ($LASTEXITCODE -eq 0) {
    Log-Success "All containers stopped and removed."  
}
else {
    Log-Error "Something went wrong stopping the containers."
}

