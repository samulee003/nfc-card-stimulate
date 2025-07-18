# NFC Door Card Simulator

[![Android CI](https://github.com/samulee003/nfc-card-stimulate/actions/workflows/android.yml/badge.svg)](https://github.com/samulee003/nfc-card-stimulate/actions/workflows/android.yml)

一個用於模擬NFC門禁卡的Android應用程式。

## 功能特色

- 📱 讀取 NFC 門禁卡資訊
- 🔄 模擬已讀取的門禁卡
- 💾 儲存卡片資料供重複使用
- 🚪 支援 Mifare Classic 卡片格式

## 系統需求

- Android 5.0 (API 21) 或更高版本
- 支援 NFC 功能的 Android 裝置
- 支援 Host Card Emulation (HCE) 功能

## 安裝方式

1. 從 [Releases](https://github.com/samulee003/nfc-card-stimulate/releases) 頁面下載最新的 APK 檔案
2. 或從 [Actions](https://github.com/samulee003/nfc-card-stimulate/actions) 頁面下載最新建置的 APK

## 使用方法

1. 啟動應用程式
2. 確保裝置的 NFC 功能已開啟
3. 點擊「掃描卡片」按鈕
4. 將門禁卡靠近裝置背面的 NFC 區域
5. 卡片資訊讀取完成後，點擊「模擬卡片」開始模擬
6. 將裝置靠近門禁讀卡機進行驗證

## 開發資訊

- **開發語言**: Java
- **最低 SDK**: API 21 (Android 5.0)
- **目標 SDK**: API 33 (Android 13)
- **建置工具**: Gradle 7.5
- **JDK 版本**: Java 8

## 建置說明

專案使用 GitHub Actions 進行自動建置，每次推送代碼後會自動產生 APK 檔案。

手動建置：
```bash
cd SimpleNFCCardApp
./gradlew assembleDebug
```

## 注意事項

⚠️ **重要提醒**：
- 本應用程式僅供學習和測試用途
- 請勿用於非法用途或未經授權的門禁系統
- 使用前請確保您有權存取相關的門禁系統

## 授權條款

本專案採用 MIT 授權條款。詳見 [LICENSE](LICENSE) 檔案。

