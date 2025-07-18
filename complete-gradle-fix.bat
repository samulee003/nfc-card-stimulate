@echo off
echo ===============================================
echo Complete Gradle Offline Setup
echo ===============================================

echo Step 1: Creating all necessary directories...
mkdir "D:\nfc-door-card-app\gradle-cache" 2>nul
mkdir "D:\nfc-door-card-app\gradle-cache\wrapper" 2>nul
mkdir "D:\nfc-door-card-app\gradle-cache\wrapper\dists" 2>nul
mkdir "D:\nfc-door-card-app\gradle-cache\wrapper\dists\gradle-7.5-bin" 2>nul
mkdir "D:\nfc-door-card-app\gradle-cache\wrapper\dists\gradle-7.5-bin\f1w0cc9nuo0eivz97x2xlu9sv" 2>nul
mkdir "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-cache" 2>nul
mkdir "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-cache\wrapper" 2>nul
mkdir "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-cache\wrapper\dists" 2>nul
mkdir "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-cache\wrapper\dists\gradle-7.5-bin" 2>nul
mkdir "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-cache\wrapper\dists\gradle-7.5-bin\f1w0cc9nuo0eivz97x2xlu9sv" 2>nul

echo Step 2: Copying gradle distribution zip...
copy "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5-bin.zip" "D:\nfc-door-card-app\gradle-cache\wrapper\dists\gradle-7.5-bin\f1w0cc9nuo0eivz97x2xlu9sv\gradle-7.5-bin.zip" 2>nul
copy "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5-bin.zip" "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-cache\wrapper\dists\gradle-7.5-bin\f1w0cc9nuo0eivz97x2xlu9sv\gradle-7.5-bin.zip" 2>nul

echo Step 3: Creating OK files (to mark download complete)...
echo. > "D:\nfc-door-card-app\gradle-cache\wrapper\dists\gradle-7.5-bin\f1w0cc9nuo0eivz97x2xlu9sv\gradle-7.5-bin.zip.ok"
echo. > "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-cache\wrapper\dists\gradle-7.5-bin\f1w0cc9nuo0eivz97x2xlu9sv\gradle-7.5-bin.zip.ok"

echo Step 4: Extracting gradle to wrapper directory...
powershell -Command "Expand-Archive -Path 'D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5-bin.zip' -DestinationPath 'D:\nfc-door-card-app\gradle-cache\wrapper\dists\gradle-7.5-bin\f1w0cc9nuo0eivz97x2xlu9sv\' -Force" 2>nul
powershell -Command "Expand-Archive -Path 'D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5-bin.zip' -DestinationPath 'D:\nfc-door-card-app\SimpleNFCCardApp\gradle-cache\wrapper\dists\gradle-7.5-bin\f1w0cc9nuo0eivz97x2xlu9sv\' -Force" 2>nul

echo Step 5: Creating wrapper jar files...
copy "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5\lib\plugins\gradle-wrapper-7.5.jar" "D:\nfc-door-card-app\gradle\wrapper\gradle-wrapper.jar" 2>nul
copy "D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5\lib\plugins\gradle-wrapper-7.5.jar" "D:\nfc-door-card-app\SimpleNFCCardApp\gradle\wrapper\gradle-wrapper.jar" 2>nul

echo Step 6: Verification...
if exist "D:\nfc-door-card-app\gradle-cache\wrapper\dists\gradle-7.5-bin\f1w0cc9nuo0eivz97x2xlu9sv\gradle-7.5" (
    echo ✅ Gradle wrapper distribution ready
) else (
    echo ❌ Wrapper setup failed
)

echo.
echo ===============================================
echo IMPORTANT: Android Studio Configuration
echo ===============================================
echo 1. Close Android Studio completely
echo 2. Reopen Android Studio
echo 3. File → Settings → Build Tools → Gradle
echo 4. Use Gradle from: Specified location
echo 5. Gradle home: D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5
echo 6. Gradle user home: D:\nfc-door-card-app\gradle-cache
echo ===============================================
pause 