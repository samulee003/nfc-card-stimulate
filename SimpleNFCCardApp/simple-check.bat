@echo off
title NFC環境檢查工具
color 0E
echo ===================================
echo NFC門禁卡APP - 基礎環境檢查
echo ===================================
echo.

REM 設置變數
set JAVA_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\jdk8\jdk8u402-b06
set GRADLE_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5

echo [檢查1] 檢查目錄結構...
echo 當前位置: %CD%
if exist "%JAVA_HOME%" (
    echo ✅ JDK目錄存在: %JAVA_HOME%
) else (
    echo ❌ JDK目錄不存在: %JAVA_HOME%
)

if exist "%GRADLE_HOME%" (
    echo ✅ Gradle目錄存在: %GRADLE_HOME%
) else (
    echo ❌ Gradle目錄不存在: %GRADLE_HOME%
)

echo.
echo [檢查2] 檢查可執行檔...
if exist "%JAVA_HOME%\bin\java.exe" (
    echo ✅ Java可執行檔存在
    echo 測試Java版本:
    "%JAVA_HOME%\bin\java.exe" -version 2>&1
) else (
    echo ❌ Java可執行檔不存在
)

echo.
if exist "%GRADLE_HOME%\bin\gradle.bat" (
    echo ✅ Gradle批次檔存在
) else (
    echo ❌ Gradle批次檔不存在
)

echo.
echo [檢查3] 檢查Android SDK...
if exist "C:\Users\emily\AppData\Local\Android\Sdk" (
    echo ✅ Android SDK目錄存在
    echo SDK內容:
    dir "C:\Users\emily\AppData\Local\Android\Sdk" /B 2>nul | findstr /i "platform build-tools"
) else (
    echo ❌ Android SDK目錄不存在
)

echo.
echo [檢查4] 檢查專案檔案...
if exist "build.gradle" (
    echo ✅ build.gradle 存在
) else (
    echo ❌ build.gradle 不存在
)

if exist "app\build.gradle" (
    echo ✅ app\build.gradle 存在
) else (
    echo ❌ app\build.gradle 不存在
)

echo.
echo ===================================
echo 環境檢查完成
echo 請檢查上面的結果，找出❌標記的問題
echo ===================================
echo.
echo 請按任意鍵關閉...
pause >nul 