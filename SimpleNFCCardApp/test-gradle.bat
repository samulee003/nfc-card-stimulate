@echo off
title Gradle Test
echo Starting basic Gradle test...
echo.

REM Setup paths
set JAVA_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\jdk8\jdk8u402-b06
set GRADLE_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5
set PATH=%JAVA_HOME%\bin;%GRADLE_HOME%\bin;%PATH%

echo JAVA_HOME set to: %JAVA_HOME%
echo GRADLE_HOME set to: %GRADLE_HOME%
echo.

cd /d "D:\nfc-door-card-app\SimpleNFCCardApp"
echo Changed to: %CD%
echo.

echo Testing Java command:
java -version
echo Java test result: %errorlevel%
echo.

echo Testing Gradle path:
where gradle
echo.

echo Testing Gradle help (this may take time on first run):
gradle help
echo Gradle help result: %errorlevel%
echo.

echo If you see this message, Gradle is working!
echo Press any key to continue...
pause 