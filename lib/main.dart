import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_gigger_app/core/helpers/notification_helper.dart';
import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/core/route/router_config.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/splash/splash_screen.dart';
import 'package:mobile_gigger_app/firebase_options.dart';
import 'package:mobile_gigger_app/widgets/network_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'core/consts/color.dart';
import 'core/utils/size_utils.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationHelper.initialize(requestPermission: false);
  await NotificationHelper.show(message);

  // await AwesomeNotificationsHelper.init();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // await AwesomeNotificationsHelper.init();

  if (kReleaseMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  var storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
  );

  var pref = await SharedPreferences.getInstance();

  if (!pref.containsKey('first_time')) {
    await storage.deleteAll();
    await pref.setBool('first_time', true);
  }

  final client = StreamChatClient('3ptyb3jnvkmu', logLevel: Level.INFO);

  runApp(
    ProviderScope(
      overrides: [
        secureStorageProvider.overrideWithValue(storage),
      ],
      child: MyApp(client),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp(this.client, {super.key});

  final StreamChatClient client;

  ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: colorBlack,
        colorScheme: ColorScheme.fromSeed(
          primary: colorRed,
          seedColor: colorRed,
          secondary: colorRed,
          brightness: Brightness.dark,
        ),
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(
            fontSize: SizeUtils.textSizeNormal,
            color: colorTextWhite,
          ),
        ),
        dialogTheme: const DialogTheme(
          contentTextStyle: TextStyle(color: colorTextBlack),
          titleTextStyle: TextStyle(
            color: colorTextBlack,
            fontSize: SizeUtils.textSizeLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        // dialogTheme: const DialogTheme(
        //   contentTextStyle: TextStyle(color: colorTextBlack),
        //   titleTextStyle: TextStyle(
        //     color: colorTextBlack,
        //     fontSize: SizeUtils.textSizeLarge,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(
            color: colorTextBlack,
            fontSize: SizeUtils.textSizeExtraSmall,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            color: colorTextHint,
            fontSize: SizeUtils.textSizeExtraSmall,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          dragHandleColor: colorWhite,
        ),
        timePickerTheme: const TimePickerThemeData(
          dayPeriodColor: colorRed,
          backgroundColor: colorBlack,
          entryModeIconColor: colorWhite,
          hourMinuteTextColor: colorWhite,
          helpTextStyle: TextStyle(color: colorWhite),
        ),
        appBarTheme: AppBarTheme(backgroundColor: colorBlack),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerConfigProvider);
    var auth = ref.watch(authControllerProvider);

    return ScreenUtilInit(
      builder: (context, child) {
        return auth.when(
          data: (_) => MaterialApp.router(
            theme: theme,
            routerConfig: router,
            title: 'Mobile Gigger App',
            debugShowCheckedModeBanner: false,
            builder: (_, widget) => NetworkChecker(
              child: StreamChat(client: client, child: widget),
            ),
          ),
          loading: () => MaterialApp(
            theme: theme,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          ),
          error: (error, stackTrace) => MaterialApp(
            theme: theme,
            home: Scaffold(body: Center(child: Text('$error'))),
          ),
        );
      },
    );
  }
}
