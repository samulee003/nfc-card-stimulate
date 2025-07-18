# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.

# Keep NFC classes
-keep class android.nfc.** { *; }
-keep class android.nfc.cardemulation.** { *; }

# Keep our app classes
-keep class com.nfcdoor.app.** { *; } 