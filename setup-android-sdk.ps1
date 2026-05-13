# Android SDK Setup Script
# This script downloads and installs minimal Android SDK components

$sdkUrl = "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
$sdkDir = "D:\Android\Sdk"
$tempDir = "$env:TEMP"

Write-Host "=== Android SDK Setup ===" -ForegroundColor Green

# Create SDK directory
New-Item -ItemType Directory -Force -Path $sdkDir | Out-Null

# Download command line tools
Write-Host "Downloading Android SDK Command Line Tools..." -ForegroundColor Yellow
$zipPath = "$tempDir\android-cmdline-tools.zip"
try {
    Invoke-WebRequest -Uri $sdkUrl -OutFile $zipPath -UseBasicParsing
    Write-Host "Download complete!" -ForegroundColor Green
} catch {
    Write-Host "Download failed. Please download manually from:" -ForegroundColor Red
    Write-Host "https://developer.android.com/studio#command-tools" -ForegroundColor Cyan
    exit 1
}

# Extract
Write-Host "Extracting..." -ForegroundColor Yellow
Expand-Archive -Path $zipPath -DestinationPath "$sdkDir\cmdline-tools" -Force
Rename-Item -Path "$sdkDir\cmdline-tools\cmdline-tools" -NewName "latest" -Force
Remove-Item $zipPath -Force

# Setup environment
$env:ANDROID_HOME = $sdkDir
$env:PATH = "$sdkDir\cmdline-tools\latest\bin;$sdkDir\platform-tools;$env:PATH"

# Accept licenses
Write-Host "Accepting SDK licenses..." -ForegroundColor Yellow
"y`n" * 10 | & "$sdkDir\cmdline-tools\latest\bin\sdkmanager.bat" --licenses 2>$null

# Install required packages
Write-Host "Installing SDK Platform 33..." -ForegroundColor Yellow
& "$sdkDir\cmdline-tools\latest\bin\sdkmanager.bat" "platforms;android-33" --sdk_root=$sdkDir

Write-Host "Installing Build Tools..." -ForegroundColor Yellow
& "$sdkDir\cmdline-tools\latest\bin\sdkmanager.bat" "build-tools;33.0.0" --sdk_root=$sdkDir

Write-Host "Installing Platform Tools..." -ForegroundColor Yellow
& "$sdkDir\cmdline-tools\latest\bin\sdkmanager.bat" "platform-tools" --sdk_root=$sdkDir

# Create licenses
$licensesDir = "$sdkDir\licenses"
New-Item -ItemType Directory -Force -Path $licensesDir | Out-Null
@"
24333f8a63b6825ea9c5514f83c2829b004d1fee
84831b9409646a918e30573bab4c9c91346d8abd
d56f5187479451eabf01fb78af6dfcb131a6481e
"@ | Out-File -FilePath "$licensesDir\android-sdk-license" -Encoding ASCII

Write-Host "`n=== Setup Complete ===" -ForegroundColor Green
Write-Host "SDK Location: $sdkDir" -ForegroundColor Cyan
Write-Host "`nAdd to your system environment variables:" -ForegroundColor Yellow
Write-Host "ANDROID_HOME = $sdkDir" -ForegroundColor White
Write-Host "PATH += %ANDROID_HOME%\platform-tools" -ForegroundColor White
