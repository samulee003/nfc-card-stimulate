# Build Instructions for NFC Door Card App

## Introduction

These instructions will guide you through the process of building the NFC Door Card App from the source code.

## Prerequisites

Before you begin, you will need to have the following software installed on your system:

*   **Java Development Kit (JDK) 8:** You can download it from the [Oracle website](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html).
*   **Android Studio:** You can download it from the [Android Developer website](https://developer.android.com/studio).
*   **Android SDK:** Make sure you have the Android SDK installed, and that you have the Android 4.4 (API 19) SDK Platform installed.

## Building the APK

1.  **Open the project in Android Studio:**
    *   Launch Android Studio.
    *   Select "Open an existing Android Studio project".
    *   Navigate to the `NFCDemo` directory in the project's root folder and click "OK".

2.  **Configure the JDK:**
    *   In Android Studio, go to "File" > "Project Structure".
    *   Under "SDK Location", make sure that the "JDK location" is pointing to your JDK 8 installation.

3.  **Build the APK:**
    *   Go to "Build" > "Build Bundle(s) / APK(s)" > "Build APK(s)".
    *   Android Studio will now build the APK.
    *   Once the build is complete, you will see a notification in the bottom-right corner of the screen.
    *   Click on the "locate" link in the notification to find the generated APK file. The APK will be located in the `NFCDemo/app/build/outputs/apk/debug` directory.

## Installing the APK

1.  **Enable "Unknown sources" on your Android device:**
    *   Go to "Settings" > "Security".
    *   Enable the "Unknown sources" option.

2.  **Copy the APK to your device:**
    *   Connect your Android device to your computer.
    *   Copy the generated APK file to your device's internal storage or SD card.

3.  **Install the APK:**
    *   On your Android device, open a file manager app and navigate to the location where you copied the APK file.
    *   Tap on the APK file to begin the installation.
    *   Follow the on-screen instructions to complete the installation.

## Conclusion

You have now successfully built and installed the NFC Door Card App.
