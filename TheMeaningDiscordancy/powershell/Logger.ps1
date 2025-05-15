. ".\EmojiConstants.ps1"

function Log-Info {
    param([string]$Message)
    Write-Output "$EmojiInfo $Message"
}

function Log-Success {
    param([string]$Message)
    Write-Output "$EmojiCheck $Message"
}

function Log-Error {
    param([string]$Message)
    Write-Error "$EmojiError $Message"
}

function Log-Stop{
    param([string]$Message)
    Write-Output "$EmojiStop $Message"
}