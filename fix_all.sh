#!/bin/bash
cd ~/Downloads/gigger-main\ 3

echo "🔧 Fixing record_android..."
cat > "$HOME/.pub-cache/hosted/pub.dev/record_android-1.5.2/android/build.gradle" << 'EOF'
apply plugin: 'com.android.library'
apply plugin: 'kotlin-android'

android {
    namespace 'com.baseflow.record'
    compileSdkVersion 34
    
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    
    kotlinOptions {
        jvmTarget = '1.8'
    }
    
    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }
    
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.9.22"
}
EOF

echo "✅ record_android fixed!"

echo "📦 Getting packages..."
fvm flutter pub get

echo "🧹 Cleaning..."
fvm flutter clean

echo "🚀 Running..."
fvm flutter run