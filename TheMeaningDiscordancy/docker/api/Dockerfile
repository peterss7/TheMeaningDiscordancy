# Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ./src/TheMeaningDiscordancy.Api/TheMeaningDiscordancy.Api.csproj ./TheMeaningDiscordancy.Api/
COPY ./src/TheMeaningDiscordancy.Core/TheMeaningDiscordancy.Core.csproj ./TheMeaningDiscordancy.Core/
COPY ./src/TheMeaningDiscordancy.Infrastructure/TheMeaningDiscordancy.Infrastructure.csproj ./TheMeaningDiscordancy.Infrastructure/

RUN dotnet restore ./TheMeaningDiscordancy.Api/TheMeaningDiscordancy.Api.csproj

# Copy
COPY ./src/TheMeaningDiscordancy.Api ./TheMeaningDiscordancy.Api
COPY ./src/TheMeaningDiscordancy.Core ./TheMeaningDiscordancy.Core
COPY ./src/TheMeaningDiscordancy.Infrastructure ./TheMeaningDiscordancy.Infrastructure

WORKDIR /src/TheMeaningDiscordancy.Api
RUN dotnet publish "TheMeaningDiscordancy.Api.csproj" -c Release -o /app/publish

# Runtime
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "TheMeaningDiscordancy.Api.dll"]
