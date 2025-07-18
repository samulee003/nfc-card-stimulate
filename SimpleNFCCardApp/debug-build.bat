@echo off
color 0A
echo ===================================================
echo NFC門禁卡APP 診斷建置腳本 v2.0
echo ===================================================
echo.

REM 設置關鍵環境變數
set JAVA_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\jdk8\jdk8u402-b06
set GRADLE_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5
set ANDROID_SDK_ROOT=C:\Users\emily\AppData\Local\Android\Sdk
set PATH=%JAVA_HOME%\bin;%GRADLE_HOME%\bin;%PATH%

echo [步驟 1] 環境變數設置：
echo JAVA_HOME: %JAVA_HOME%
echo GRADLE_HOME: %GRADLE_HOME%
echo ANDROID_SDK_ROOT: %ANDROID_SDK_ROOT%
echo.
pause

echo [步驟 2] 檢查Java安裝...
if not exist "%JAVA_HOME%\bin\java.exe" (
    echo ❌ 錯誤：找不到Java可執行檔
    echo 路徑：%JAVA_HOME%\bin\java.exe
    pause
    exit /b 1
)
echo ✅ Java路徑正確
"%JAVA_HOME%\bin\java.exe" -version
echo.
pause

echo [步驟 3] 檢查Gradle安裝...
if not exist "%GRADLE_HOME%\bin\gradle.bat" (
    echo ❌ 錯誤：找不到Gradle可執行檔
    echo 路徑：%GRADLE_HOME%\bin\gradle.bat
    pause
    exit /b 1
)
echo ✅ Gradle路徑正確
pause

echo [步驟 4] 檢查Android SDK...
if not exist "%ANDROID_SDK_ROOT%" (
    echo ❌ 錯誤：找不到Android SDK目錄
    echo 路徑：%ANDROID_SDK_ROOT%
    pause
    exit /b 1
)
echo ✅ Android SDK路徑存在
pause

echo [步驟 5] 切換到專案目錄...
cd /d "D:\nfc-door-card-app\SimpleNFCCardApp"
echo 當前目錄：%CD%
pause

echo [步驟 6] 測試Gradle版本...
gradle -version
if errorlevel 1 (
    echo ❌ Gradle版本檢查失敗
    pause
    exit /b 1
)
echo ✅ Gradle可正常運行
pause

echo [步驟 7] 開始清理專案...
gradle clean
if errorlevel 1 (
    echo ❌ Gradle clean失敗
    pause
    exit /b 1
)
echo ✅ 專案清理完成
pause

echo [步驟 8] 開始建置APK...
gradle assembleDebug
if errorlevel 1 (
    echo ❌ APK建置失敗
    pause
    exit /b 1
)

echo.
echo ========================================
echo 🎉 建置成功完成！
echo APK位置: app\build\outputs\apk\debug\
echo ========================================
dir app\build\outputs\apk\debug\*.apk
pause 