import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Load the keystore properties from key.properties
val keyStoreProperties = Properties()
val keyStorePropertiesFile = rootProject.file("key.properties")
if (keyStorePropertiesFile.exists()) {
    keyStoreProperties.load(FileInputStream(keyStorePropertiesFile))
}

android {
    namespace = "app.ai.mailmuse"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
        create("release") {
            keyAlias = keyStoreProperties.getProperty("keyAlias")
            keyPassword = keyStoreProperties.getProperty("keyPassword")
            storeFile = file(keyStoreProperties.getProperty("storeFile"))
            storePassword = keyStoreProperties.getProperty("storePassword")
        }
    }

    defaultConfig {
        applicationId = "app.ai.mailmuse"
        minSdk = 23
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
