# Codex Instructions — Gigger Flutter Mobile App

## 1. Project Overview

This repository contains the Flutter mobile application for the Gigger platform.

Project name:

```text
mobile_gigger_app
```

The application communicates with the Gigger backend API and uses Firebase Cloud Messaging (FCM), Firebase Crashlytics, and Stream Chat for selected functionality.

---

## 2. Technology Stack

Use the existing project versions unless there is an explicit request to upgrade them.

```text
Flutter: 3.24.5
Dart: 3.5.4
Flutter Channel: stable
Gradle: 8.14
```

Primary technologies:

* Flutter
* Dart
* Android
* iOS
* Firebase Cloud Messaging
* Firebase Crashlytics
* Stream Chat
* REST API
* Dio
* PostgreSQL-backed backend API

Do not upgrade Flutter, Dart, Gradle, Android Gradle Plugin, Kotlin, or major dependencies unless specifically requested.

---

## 3. Important Project Rules

Before changing code:

1. Inspect the existing implementation.
2. Understand how the feature currently works.
3. Reuse existing architecture and utilities.
4. Follow existing naming and coding conventions.
5. Avoid unnecessary dependencies.
6. Do not rewrite working code without a reason.
7. Keep changes focused on the requested task.
8. Do not modify unrelated files.
9. Preserve existing API contracts unless the task explicitly requires an API change.
10. Check for existing reusable components before creating new ones.

Prefer small, maintainable changes over large refactors.

---

## 4. Project Structure

The main application code is under:

```text
lib/
```

Current high-level structure:

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

Follow the existing feature-based organization.

When adding a new feature, place it under the appropriate `lib/features/` directory.

Shared functionality should remain under the appropriate `lib/core/` directory.

---

## 5. Application Entry Point

The main application entry point is:

```text
lib/main.dart
```

Before modifying application initialization, inspect the existing Firebase, notification, routing, and provider initialization logic.

Do not remove existing initialization code unless it is confirmed to be unused.

---

## 6. Backend Configuration

The production backend API is:

```text
https://api.gigger.art
```

The production web application is:

```text
https://app.gigger.art
```

Runtime configuration uses Flutter `--dart-define`.

The primary configuration values are:

```text
BASE_URL
REDIRECT_URL
```

Configuration is defined in:

```text
lib/core/consts/const.dart
```

Do not introduce `.env`-based configuration unless explicitly requested.

Example:

```bash
flutter run \
  --dart-define=BASE_URL=https://api.gigger.art \
  --dart-define=REDIRECT_URL=https://app.gigger.art
```

For development environments, use the appropriate development API and web URLs.

Never hard-code development URLs into production logic.

---

## 7. API Development Rules

Before creating a new API request:

1. Search the existing project for similar API calls.
2. Check the existing Dio configuration.
3. Reuse existing providers/services/helpers.
4. Follow the existing request and response models.
5. Follow the existing error-handling pattern.

Do not create a second HTTP client if the existing Dio configuration can be reused.

When modifying an API endpoint, verify:

* HTTP method
* URL/path
* Request parameters
* Request body
* Headers
* Authentication
* Response model
* Error handling

Do not silently change an existing API contract.

---

## 8. Firebase

Firebase project:

```text
gigger-40284
```

Firebase is actively used by the application.

### Firebase Cloud Messaging

FCM is used for:

* Push notifications
* Notification permissions
* Foreground notifications
* Background notifications
* Local notifications
* Notification tap handling
* Chat notification routing
* FCM token registration with the Gigger API
* Stream Chat FCM token registration

Important files:

```text
lib/main.dart
lib/core/helpers/messaging_helper.dart
lib/core/helpers/notification_helper.dart
```

When modifying notification functionality, inspect these files first.

Do not create duplicate notification handlers without checking the existing implementation.

---

## 9. Firebase Crashlytics

Crashlytics is actively used for release error reporting.

The application:

* Captures uncaught Flutter/framework errors.
* Reports selected API/Dio failures.
* Reports configured HTTP 422 failures as fatal.
* Is disabled for debug builds.

Important files:

```text
lib/main.dart
lib/core/providers/dio_provider.dart
```

When changing error handling, preserve the existing Crashlytics reporting behavior unless explicitly requested otherwise.

Do not expose sensitive information through Crashlytics logs.

---

## 10. Firebase Services Currently Not Used

The application does not currently use:

```text
Firebase Authentication
Cloud Firestore
Realtime Database
Firebase Storage
Firebase Analytics
Remote Config
App Check
Dynamic Links
Cloud Functions
```

Do not introduce these services unless explicitly requested.

A Firebase Storage bucket exists in the Firebase project, but the Flutter application does not currently directly use Firebase Storage.

---

## 11. Firebase Configuration

Existing Firebase configuration files include:

```text
firebase.json
lib/firebase_options.dart
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

There is currently an important flavor configuration gap.

Expected development/production files:

```text
android/app/src/dev/google-services.json
android/app/src/prod/google-services.json

lib/firebase_options_dev.dart
lib/firebase_options_prod.dart
```

These files are currently missing.

The application currently uses:

```text
lib/firebase_options.dart
```

Therefore, do not assume that Firebase `dev` and `prod` environments are completely separated.

Before implementing or changing Firebase flavor behavior:

1. Inspect the current flavor configuration.
2. Check `firebase.json`.
3. Check `android/`.
4. Check `ios/`.
5. Check how `Firebase.initializeApp()` is currently configured.
6. Do not invent missing Firebase configuration files.
7. Clearly identify any configuration that must be provided by the development team.

---

## 12. Notification Types

The application uses numeric notification types.

Maintain compatibility with the existing values.

```text
0  REQUEST_ACCEPTED
1  NEW_FOLLOWER
2  NEW_MESSAGE
3  NEW_POST
4  NEW_LIKE
5  NEW_COMMENT
6  NEW_SHARE
7  NEW_SUBSCRIPTION
8  NEW_EVENT
9  NEW_PRO_SERVICE
10 NEW_FOLLOW_REQUEST
11 NEW_VIEW
12 NEW_PROFILE_VIEW
```

Do not change these numeric values.

If notification behavior is modified, ensure existing notification types continue to work.

### Notification Handling

When adding a new notification type:

1. Confirm the backend notification value.
2. Add the corresponding enum/type.
3. Implement notification routing.
4. Handle foreground notifications.
5. Handle background notifications where applicable.
6. Handle notification taps.
7. Verify chat-specific routing if applicable.
8. Test Android and iOS behavior.

---

## 13. Chat

The application uses Stream Chat.

FCM tokens are also registered with Stream Chat.

When modifying chat notifications:

1. Inspect the existing Stream Chat integration.
2. Inspect FCM token registration.
3. Inspect notification routing.
4. Preserve existing channel navigation behavior.

Do not create a separate notification system for chat without checking the existing implementation.

---

## 14. Authentication

Authentication-related functionality is located under:

```text
lib/features/auth/
```

Before changing authentication:

1. Inspect the existing authentication provider/service.
2. Inspect token handling.
3. Inspect API authentication headers.
4. Inspect route guards/navigation.
5. Check logout behavior.
6. Check persistent session behavior.

Do not assume Firebase Authentication is being used.

The application's authentication is separate from Firebase Authentication.

---

## 15. Routing

Routing configuration is located under:

```text
lib/core/route/
```

Before adding a new screen:

1. Inspect the existing routing system.
2. Follow the current route naming convention.
3. Add the route through the existing routing mechanism.
4. Do not introduce another routing package unless explicitly requested.

When changing navigation, verify:

* Authentication state
* Deep links where applicable
* Notification navigation
* Chat navigation
* Back navigation

---

## 16. State Management and Providers

Before adding state management:

1. Search `lib/core/providers/`.
2. Search the relevant feature directory.
3. Identify the existing state-management pattern.
4. Reuse the existing pattern.

Do not introduce another state-management library simply because it is familiar.

---

## 17. UI Development

When modifying UI:

* Follow the existing application design.
* Reuse existing widgets.
* Reuse existing theme/constants.
* Preserve responsive behavior.
* Consider Android and iOS differences.
* Avoid unnecessary UI rewrites.

Before creating a new reusable widget, search the project for an existing equivalent.

---

## 18. Dependencies

Before adding a package:

1. Check whether the functionality already exists.
2. Search `pubspec.yaml`.
3. Search the project for an existing implementation.
4. Prefer existing dependencies.
5. Add a new dependency only when necessary.

After modifying dependencies:

```bash
flutter pub get
```

Do not upgrade all packages unless explicitly requested.

Avoid dependency upgrades unrelated to the task.

---

## 19. Android

Android project files are under:

```text
android/
```

The project uses Gradle 8.14.

Gradle wrapper configuration:

```text
android/gradle/wrapper/gradle-wrapper.properties
```

Do not change the Gradle version unless explicitly requested.

Before modifying Android build configuration, inspect:

```text
android/build.gradle
android/settings.gradle
android/app/build.gradle
android/gradle.properties
android/gradle/wrapper/gradle-wrapper.properties
```

Be careful when changing:

* Gradle
* Android Gradle Plugin
* Kotlin
* compileSdk
* targetSdk
* minSdk
* Firebase configuration
* Product flavors
* Signing configuration

---

## 20. iOS

iOS project files are under:

```text
ios/
```

Before modifying iOS configuration:

1. Inspect the existing Podfile.
2. Inspect the deployment target.
3. Inspect Firebase configuration.
4. Check CocoaPods dependencies.
5. Preserve existing project settings.

Do not modify the iOS deployment target unless required by the task or dependency requirements.

---

## 21. Environment and Secrets

Never commit secrets.

Do not commit:

```text
.env
*.jks
*.keystore
key.properties
Private keys
Passwords
Access tokens
API secrets
Service-account private keys
```

Do not print secrets in terminal output, logs, commits, or generated documentation.

The following file must not be committed if it contains credentials:

```text
lib/gigger-google-service.json
```

Use secure environment/configuration mechanisms instead.

Never place passwords or private tokens in source code.

---

## 22. Git Safety

Before making Git-related changes:

```bash
git status
```

Do not:

* Force-push without explicit approval.
* Delete branches without approval.
* Rewrite Git history unless explicitly requested.
* Remove commits to hide changes.
* Commit secrets.
* Change unrelated files.

Use clear commit messages.

Recommended branch structure:

```text
main
develop
feature/<feature-name>
bugfix/<bug-name>
```

Feature branches should normally be based on:

```text
develop
```

---

## 23. Required Validation

After making code changes, run the smallest relevant validation first.

Typical checks:

```bash
flutter analyze
```

Then:

```bash
flutter test
```

If dependencies changed:

```bash
flutter pub get
flutter analyze
flutter test
```

For UI or platform changes, also run the application:

```bash
flutter run
```

For Android release-related changes:

```bash
flutter build apk --release
```

For Play Store bundle changes:

```bash
flutter build appbundle --release
```

Do not claim that tests passed unless they were actually run.

---

## 24. Debugging Rules

When fixing an error:

1. Read the complete error message.
2. Identify the actual root cause.
3. Inspect the relevant project files.
4. Check existing configuration.
5. Make the smallest appropriate fix.
6. Run the relevant validation.
7. Report any remaining issues.

Do not randomly change multiple versions or configurations to make an error disappear.

Do not downgrade or upgrade major dependencies without understanding the compatibility issue.

---

## 25. Flutter Commands

Common commands:

```bash
flutter pub get
flutter analyze
flutter test
flutter clean
flutter doctor -v
flutter devices
flutter run
```

Build debug APK:

```bash
flutter build apk --debug
```

Build release APK:

```bash
flutter build apk --release
```

Build release App Bundle:

```bash
flutter build appbundle --release
```

---

## 26. FVM

If the repository uses FVM, use the project's configured Flutter version instead of the globally installed Flutter version.

For example:

```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm flutter run
```

Do not change the project's Flutter version unless explicitly requested.

---

## 27. Code Quality

Prefer:

* Clear naming
* Small functions
* Reusable components
* Strong typing
* Existing project patterns
* Minimal duplication
* Proper error handling
* Maintainable code

Avoid:

* Unnecessary abstractions
* Large unrelated refactors
* Duplicate services
* Duplicate API clients
* Hard-coded secrets
* Temporary debugging code
* Unused imports
* Unused dependencies
* Dead code

Remove temporary debugging statements before completing the task.

---

## 28. Before Completing a Task

Before reporting a task as complete:

```text
1. Check git status.
2. Review changed files.
3. Check for accidental changes.
4. Check for secrets.
5. Run flutter analyze.
6. Run relevant tests.
7. Run the application if appropriate.
8. Confirm the requested behavior.
9. Report what was changed.
10. Report any tests or validation that could not be run.
```

Do not modify files outside the requested scope unless required to complete the task.

---

## 29. Important Principle

The existing Gigger application is the source of truth.

When implementing a feature:

```text
Existing architecture
        ↓
Existing patterns
        ↓
Existing services/providers
        ↓
Existing API behavior
        ↓
Minimal required change
```

Do not redesign the application unless explicitly asked.

When uncertain, inspect the existing implementation before introducing a new approach.