@echo off
chcp 65001 >nul
title NFC Card App Builder
color 0A

echo ================================================
echo NFC Card Emulation App - Build Script
echo ================================================
echo.

REM Setup environment variables
set JAVA_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\jdk8\jdk8u402-b06
set GRADLE_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5
set ANDROID_SDK_ROOT=C:\Users\emily\AppData\Local\Android\Sdk
set PATH=%JAVA_HOME%\bin;%GRADLE_HOME%\bin;%PATH%

echo Environment Setup Complete
echo JAVA_HOME: %JAVA_HOME%
echo GRADLE_HOME: %GRADLE_HOME%
echo ANDROID_SDK_ROOT: %ANDROID_SDK_ROOT%
echo.

echo Changing to project directory...
cd /d "D:\nfc-door-card-app\SimpleNFCCardApp"
echo Current directory: %CD%
echo.

echo Testing Gradle...
gradle -version
if errorlevel 1 (
    echo ERROR: Gradle test failed
    pause
    exit /b 1
)
echo Gradle OK
echo.

echo Starting clean...
gradle clean
if errorlevel 1 (
    echo ERROR: Clean failed
    pause
    exit /b 1
)
echo Clean completed
echo.

echo Building APK...
gradle assembleDebug --info --stacktrace
if errorlevel 1 (
    echo ERROR: Build failed - check error messages above
    pause
    exit /b 1
)

echo.
echo ================================================
echo SUCCESS! APK Build Completed
echo Location: app\build\outputs\apk\debug\
echo ================================================
dir app\build\outputs\apk\debug\*.apk 2>nul
if errorlevel 1 (
    echo APK file not found - checking build directory...
    dir app\build /s *.apk 2>nul
)
echo.
pause 