#!/bin/bash

# Fix record_android permanently
PACKAGE_DIR="$HOME/.pub-cache/hosted/pub.dev/record_android-1.5.2"

if [ -d "$PACKAGE_DIR" ]; then
    echo "🔧 Patching record_android-1.5.2..."
    
    cat > "$PACKAGE_DIR/android/build.gradle" << 'EOF'
apply plugin: 'com.android.library'
apply plugin: 'kotlin-android'

android {
    namespace 'com.baseflow.record'
    compileSdkVersion 36
    
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
        targetSdkVersion 36
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.9.22"
}
EOF
    
    echo "✅ Patch applied successfully!"
else
    echo "⚠️ Package not found. Run 'flutter pub get' first."
fi