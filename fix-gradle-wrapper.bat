@echo off
echo ================================================
echo Fixing Gradle Wrapper Setup
echo ================================================

echo Creating necessary directories...
mkdir "SimpleNFCCardApp\gradle-cache\wrapper\dists" 2>nul
mkdir "SimpleNFCCardApp\temp" 2>nul
mkdir "gradle\wrapper" 2>nul

echo Copying gradle-wrapper.jar from gradle-7.5...
copy "SimpleNFCCardApp\gradle-7.5\lib\plugins\gradle-wrapper-7.5.jar" "gradle\wrapper\gradle-wrapper.jar"

echo Copying to SimpleNFCCardApp wrapper as well...
copy "SimpleNFCCardApp\gradle-7.5\lib\plugins\gradle-wrapper-7.5.jar" "SimpleNFCCardApp\gradle\wrapper\gradle-wrapper.jar"

echo Checking wrapper files...
if exist "gradle\wrapper\gradle-wrapper.jar" (
    echo ✅ Root gradle-wrapper.jar created
) else (
    echo ❌ Failed to create root gradle-wrapper.jar
)

if exist "SimpleNFCCardApp\gradle\wrapper\gradle-wrapper.jar" (
    echo ✅ SimpleNFCCardApp gradle-wrapper.jar created
) else (
    echo ❌ Failed to create SimpleNFCCardApp gradle-wrapper.jar
)

echo.
echo ================================================
echo Gradle Wrapper Fixed!
echo Now close Android Studio completely and reopen
echo Then try to sync the project again
echo ================================================
pause 