@echo off
echo =================================
echo NFC門禁卡APP快速建置腳本
echo =================================

REM 設置JAVA_HOME到我們的可攜式JDK 8
set JAVA_HOME=D:\nfc-door-card-app\SimpleNFCCardApp\jdk8\jdk8u402-b06
echo JAVA_HOME設置為: %JAVA_HOME%

REM 切換到專案目錄
cd /d "D:\nfc-door-card-app\SimpleNFCCardApp"

REM 顯示Java版本驗證
echo.
echo 驗證Java版本:
"%JAVA_HOME%\bin\java.exe" -version

REM 執行Gradle建置
echo.
echo 開始建置APK...
"D:\nfc-door-card-app\SimpleNFCCardApp\gradle-7.5\bin\gradle.bat" assembleDebug

echo.
echo 建置完成！檢查app\build\outputs\apk\debug\目錄
pause 