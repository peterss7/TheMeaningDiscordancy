. "$PSScriptRoot\EmojiConstants.ps1"

Write-Output "$EmojiBuild Preparing container environment..."

# (Optional setup logic)

Write-Output "$EmojiLaunch Launching ASP.NET Core app..."
dotnet /app/TheMeaningDiscordancy.Api.dll