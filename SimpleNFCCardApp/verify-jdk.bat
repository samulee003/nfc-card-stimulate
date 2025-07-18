@echo off
echo Verifying JDK Path...
echo.

set JDK_PATH=D:\nfc-door-card-app\SimpleNFCCardApp\jdk8\jdk8u402-b06

echo Testing JDK path: %JDK_PATH%
echo.

if exist "%JDK_PATH%\bin\java.exe" (
    echo ✅ java.exe found
    echo Testing Java version:
    "%JDK_PATH%\bin\java.exe" -version
    echo.
    echo ✅ JDK path is VALID
) else (
    echo ❌ java.exe NOT found
    echo ❌ JDK path is INVALID
)

echo.
echo Gradle properties path format:
echo org.gradle.java.home=%JDK_PATH:\=\\%
echo.
pause 