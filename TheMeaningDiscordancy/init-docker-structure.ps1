# Root docker folder
$dockerRoot = "docker"
$components = @("api", "nlp", "db")

# Create root docker folder if it doesn't exist
if (-not (Test-Path $dockerRoot)) {
    New-Item -ItemType Directory -Path $dockerRoot | Out-Null
}

# For each component, create a docker subfolder and a basic Dockerfile
foreach ($comp in $components) {
    $folder = "$dockerRoot/$comp"
    $dockerfile = "$folder/Dockerfile"

    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
    }

    if (-not (Test-Path $dockerfile)) {
        switch ($comp) {
            "api" {
@"
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ./src/TheMeaningDiscordancy.Api/TheMeaningDiscordancy.Api.csproj ./TheMeaningDiscordancy.Api/
COPY ./src/TheMeaningDiscordancy.Core/TheMeaningDiscordancy.Core.csproj ./TheMeaningDiscordancy.Core/
COPY ./src/TheMeaningDiscordancy.Persistence/TheMeaningDiscordancy.Persistence.csproj ./TheMeaningDiscordancy.Persistence/

RUN dotnet restore ./TheMeaningDiscordancy.Api/TheMeaningDiscordancy.Api.csproj
COPY ./src ./src
WORKDIR /src/TheMeaningDiscordancy.Api
RUN dotnet publish "TheMeaningDiscordancy.Api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "TheMeaningDiscordancy.Api.dll"]
"@ | Out-File -FilePath $dockerfile -Encoding UTF8
            }
            "nlp" {
@"
# TODO: Add Dockerfile for Python-based NLP container
FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
"@ | Out-File -FilePath $dockerfile -Encoding UTF8
            }
            "db" {
@"
# Optional: SQL Server init script or placeholder
# You can use this directory to store seed SQL scripts
"@ | Out-File -FilePath $dockerfile -Encoding UTF8
            }
        }

        Write-Host "Created: $dockerfile"
    }
    else {
        Write-Host "Already exists: $dockerfile"
    }
}

Write-Host "`nDocker scaffolding complete!"
