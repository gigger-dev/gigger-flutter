# mobile_gigger_app

Gigger is a Flutter mobile application for the Gigger platform.

## Project Information

| Item             | Version / Information    |
| ---------------- | ------------------------ |
| Project Name     | `mobile_gigger_app`      |
| Flutter          | 3.24.5                   |
| Flutter Channel  | Stable                   |
| Dart             | 3.5.4                    |
| Gradle           | 8.14                     |
| Firebase Project | `gigger-40284`           |
| Backend API      | `https://api.gigger.art` |
| Web App          | `https://app.gigger.art` |

## Requirements

Before running the project, make sure the following are installed:

* Flutter 3.24.5
* Dart 3.5.4
* Android Studio
* Android SDK
* Xcode (for iOS development)
* CocoaPods (for iOS development)
* Java/JDK compatible with the Android Gradle configuration

## Flutter Version

This project was developed using:

```text
Flutter 3.24.5
Dart 3.5.4
Channel: stable
Release Date: November 14, 2024
```

Check your Flutter version:

```bash
flutter --version
```

If using FVM, make sure the project is configured to use Flutter 3.24.5.

## Getting Started

This project is a Flutter mobile application.

If you are new to Flutter, the following official resources are useful:

* [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
* [Flutter Cookbook](https://docs.flutter.dev/cookbook)
* [Flutter Documentation](https://docs.flutter.dev/)

The Flutter documentation provides tutorials, samples, guidance for mobile development, and a full API reference.

## Gradle

The project uses Gradle 8.14.

Gradle distribution:

```text
https://services.gradle.org/distributions/gradle-8.14-all.zip
```

The Gradle configuration can be found under:

```text
android/gradle/wrapper/gradle-wrapper.properties
```

## Installation

Clone the repository:

```bash
git clone <repository-url>
```

Enter the project directory:

```bash
cd mobile_gigger_app
```

Install Flutter dependencies:

```bash
flutter pub get
```

## Run the Application

Run on a connected device or emulator:

```bash
flutter run
```

To check available devices:

```bash
flutter devices
```

Run on a specific device:

```bash
flutter run -d <device-id>
```

## Build APK

For a debug APK:

```bash
flutter build apk --debug
```

For a release APK:

```bash
flutter build apk --release
```

The generated APK will normally be located under:

```text
build/app/outputs/flutter-apk/
```

## Build App Bundle

For Google Play Store deployment:

```bash
flutter build appbundle --release
```

The generated AAB will normally be located under:

```text
build/app/outputs/bundle/release/
```

# Firebase Configuration

Firebase is configured and actively used in this project.

Firebase Project:

```text
gigger-40284
```

## Firebase Features Used

### Firebase Cloud Messaging (FCM)

Firebase Cloud Messaging is used for push notifications.

The application:

* Requests notification permissions.
* Receives foreground notifications.
* Receives background notifications.
* Displays notifications using local Android/iOS notifications.
* Handles notification taps.
* Routes chat notifications to the appropriate chat channel.
* Sends the FCM token to the Gigger API.
* Registers the FCM token with Stream Chat.

Main files:

```text
lib/main.dart
lib/core/helpers/messaging_helper.dart
lib/core/helpers/notification_helper.dart
```

### Firebase Crashlytics

Firebase Crashlytics is used for crash and error reporting in release builds.

The application:

* Captures uncaught Flutter/framework errors.
* Reports selected API/Dio failures.
* Reports HTTP 422 failures as fatal errors where configured.
* Is disabled for debug builds.

Main files:

```text
lib/main.dart
lib/core/providers/dio_provider.dart
```

## Firebase Features Not Used

The following Firebase services are currently not used by the Flutter application:

* Firebase Authentication
* Cloud Firestore
* Realtime Database
* Firebase Storage
* Firebase Analytics
* Remote Config
* App Check
* Dynamic Links
* Cloud Functions

> **Note:** A Firebase Storage bucket is configured in the Firebase project, but the Flutter application does not currently use the `firebase_storage` package or directly access Firebase Storage.

# Firebase Configuration Files

The repository contains the following Firebase configuration files:

```text
firebase.json
lib/firebase_options.dart
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

## Important Firebase Flavor Configuration

`firebase.json` declares separate Firebase configurations for:

```text
dev
prod
```

However, the following files are currently missing:

```text
android/app/src/dev/google-services.json
android/app/src/prod/google-services.json

lib/firebase_options_dev.dart
lib/firebase_options_prod.dart
```

The application currently imports the default:

```text
lib/firebase_options.dart
```

Therefore, the `dev` flavor may currently use the default Firebase configuration instead of a separate development Firebase application.

### Action Required

Before relying on separate Firebase environments for development and production, verify and configure:

```text
dev Firebase App
prod Firebase App
```

and generate the appropriate FlutterFire configuration files.

This is especially important for separating:

* FCM notifications
* Crashlytics reports
* Development data
* Production data

# Runtime Configuration

This project does **not** use a `.env` file.

Runtime configuration is provided using Flutter's `--dart-define`.

The main configuration values are:

```text
BASE_URL
REDIRECT_URL
```

Default values:

```text
BASE_URL=https://api.gigger.art
REDIRECT_URL=https://app.gigger.art
```

The configuration can be found in:

```text
lib/core/consts/const.dart
```

## Running with Custom Configuration

Example:

```bash
flutter run \
  --dart-define=BASE_URL=https://api.gigger.art \
  --dart-define=REDIRECT_URL=https://app.gigger.art
```

For different environments, replace the values accordingly.

Example development configuration:

```bash
flutter run \
  --dart-define=BASE_URL=<development-api-url> \
  --dart-define=REDIRECT_URL=<development-web-url>
```

> Do not commit passwords, private API keys, tokens, signing credentials, or other secrets to the repository.

# Notification Types

The application uses notification types to identify different notification events.

The notification type values are:

| Value | Notification Type    | Description                |
| ----: | -------------------- | -------------------------- |
|   `0` | `REQUEST_ACCEPTED`   | A request was accepted     |
|   `1` | `NEW_FOLLOWER`       | A new follower             |
|   `2` | `NEW_MESSAGE`        | A new message              |
|   `3` | `NEW_POST`           | A new post                 |
|   `4` | `NEW_LIKE`           | A new like                 |
|   `5` | `NEW_COMMENT`        | A new comment              |
|   `6` | `NEW_SHARE`          | A post was shared          |
|   `7` | `NEW_SUBSCRIPTION`   | A new subscription         |
|   `8` | `NEW_EVENT`          | A new event                |
|   `9` | `NEW_PRO_SERVICE`    | A new professional service |
|  `10` | `NEW_FOLLOW_REQUEST` | A new follow request       |
|  `11` | `NEW_VIEW`           | A new view                 |
|  `12` | `NEW_PROFILE_VIEW`   | A profile view             |

Equivalent enum definition:

```python
class NotificationType(Enum):
    REQUEST_ACCEPTED = 0
    NEW_FOLLOWER = 1
    NEW_MESSAGE = 2
    NEW_POST = 3
    NEW_LIKE = 4
    NEW_COMMENT = 5
    NEW_SHARE = 6
    NEW_SUBSCRIPTION = 7
    NEW_EVENT = 8
    NEW_PRO_SERVICE = 9
    NEW_FOLLOW_REQUEST = 10
    NEW_VIEW = 11
    NEW_PROFILE_VIEW = 12
```

# Login Information

The project/customer account email is:

```text
gigger.development@gmail.com
```

> **Security:** Do not store the account password in this README or in the Git repository. Share passwords through a secure password manager or another approved secure communication channel.

# Project Structure

The main Flutter source code is located under:

```text
lib/
```

Important directories include:

```text
lib/
├── core/
│   ├── consts/
│   ├── extension/
│   ├── helpers/
│   ├── providers/
│   ├── route/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── availability/
│   ├── calendar/
│   ├── chat/
│   └── ...
│
└── main.dart
```

# Useful Flutter Commands

Get dependencies:

```bash
flutter pub get
```

Upgrade dependencies:

```bash
flutter pub upgrade
```

Analyze the project:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Clean generated files:

```bash
flutter clean
```

Reinstall dependencies:

```bash
flutter clean
flutter pub get
```

Check Flutter environment:

```bash
flutter doctor -v
```

Check connected devices:

```bash
flutter devices
```

# Development Workflow

Recommended workflow:

```text
1. Pull the latest changes
2. Create/switch to the development branch
3. Run flutter pub get
4. Run the application
5. Make changes
6. Run flutter analyze
7. Run tests
8. Commit changes
9. Push changes
10. Merge to production when approved
```

Example:

```bash
git checkout develop
git pull

flutter pub get
flutter analyze
flutter test

flutter run
```

# Git Branches

Recommended branches:

```text
main
develop
feature/<feature-name>
bugfix/<bug-name>
```

### Main

The `main` branch represents the production/customer-ready version.

### Develop

The `develop` branch is used for active development and testing.

### Feature

Feature branches should be created from `develop`.

Example:

```bash
git checkout develop
git checkout -b feature/chat-notification
```

# Security

Never commit the following to GitHub:

```text
.env
*.jks
*.keystore
key.properties
Passwords
API secrets
Private keys
Access tokens
Service account private keys
```

Firebase configuration files may contain project/application identifiers and should be reviewed according to the team's Firebase security policy before being committed.

# Notes

* Firebase Cloud Messaging is actively used.
* Firebase Crashlytics is actively used for release error reporting.
* The application does not currently use Firebase Authentication or Firestore.
* Runtime configuration uses `--dart-define`.
* There is currently no `.env` file.
* Firebase `dev`/`prod` flavor configuration should be verified before using separate development and production Firebase environments.
* Flutter version: **3.24.5**
* Dart version: **3.5.4**
* Gradle version: **8.14**
# gigger-flutter
# gigger-flutter
