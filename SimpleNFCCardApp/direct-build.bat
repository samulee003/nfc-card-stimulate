@echo off
echo ==========================================
echo NFC門禁卡APP直接建置腳本 (無wrapper版本)
echo ==========================================

REM 設置關鍵環境變數
set JAVA_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\jdk8\jdk8u402-b06
set GRADLE_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5
set PATH=%JAVA_HOME%\bin;%GRADLE_HOME%\bin;%PATH%

echo JAVA_HOME: %JAVA_HOME%
echo GRADLE_HOME: %GRADLE_HOME%
echo.

REM 切換到專案目錄
cd /d "D:\nfc-door-card-app\SimpleNFCCardApp"

REM 顯示版本資訊
echo 檢查Java版本:
java -version
echo.

echo 檢查Gradle版本:
gradle -version
echo.

REM 清理並建置
echo 開始清理專案...
gradle clean

echo.
echo 開始建置Debug APK...
gradle assembleDebug

echo.
echo =====================================
echo 建置完成！
echo APK位置: app\build\outputs\apk\debug\
echo =====================================
pause 