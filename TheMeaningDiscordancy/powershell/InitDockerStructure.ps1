. ".\Logger.ps1"
$RootPath = Resolve-Path "$PSScriptRoot\.."
. "$PSScriptRoot\Logger.ps1"
$envPath = "$RootPath\.env"
$dockerRoot = $DOCKER_ROOT
$components = APP_COMPONENTS # @("api", "nlp", "db")

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


# Create root docker folder if it doesn't exist
if (-not (Test-Path $dockerRoot)) {
    Log-Info "Creating docker root folder for application."
    New-Item -ItemType Directory -Path $dockerRoot | Out-Null
}

# For each component, create a docker subfolder and a basic Dockerfile
foreach ($comp in $components) {
    $folder = "$dockerRoot/$comp"

    if (-not (Test-Path $folder)) {
        Log-Info "Creating docker folder for $comp component."
        New-Item -ItemType Directory -Path $folder | Out-Null
    }
}

Log-Success "Docker scaffolding complete!"
