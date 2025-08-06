plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Firebase
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter
}

android {
    namespace = "com.example.chatapp"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.chatapp"
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }

    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            isShrinkResources = false // ✅ Fix added here
            signingConfig = signingConfigs.getByName("debug") // Replace later with release key
        }
    }
}

flutter {
    source = "../.."
}
