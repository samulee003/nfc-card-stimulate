@echo off
echo Creating temporary directories...

mkdir "D:\nfc-door-card-app\SimpleNFCCardApp\temp" 2>nul
mkdir "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-cache" 2>nul

echo Directories created:
echo - D:\nfc-door-card-app\SimpleNFCCardApp\temp
echo - D:\nfc-door-card-app\SimpleNFCCardApp\gradle-cache

echo.
echo Now configure Android Studio Gradle settings:
echo 1. File → Settings → Build Tools → Gradle
echo 2. Use Gradle from: D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5
echo 3. JVM arguments: -Djava.io.tmpdir=D:\nfc-door-card-app\SimpleNFCCardApp\temp
echo.
pause 