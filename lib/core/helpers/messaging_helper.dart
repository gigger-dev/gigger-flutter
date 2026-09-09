import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_gigger_app/core/helpers/notification_helper.dart';
import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/route/router_config.dart';
import 'package:mobile_gigger_app/features/main/providers/noti_token_controller.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MessagingHelper {
  static Future<void> initialize() async {
    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
      announcement: true,
    );

    FirebaseMessaging.onMessage.listen(NotificationHelper.show);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      var context = rootNavigatorKey.currentState?.context;
      if (context == null || !context.mounted) return;

      var channelId = message.data['channel_id'];
      if (channelId == null) return;

      ChatRoute(channelId: channelId).go(context);
    });

    listenTokenRefresh();
  }

  static Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
  }

  static void listenTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      var ref = ProviderContainer(
        overrides: [
          secureStorageProvider.overrideWithValue(
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                keyCipherAlgorithm:
                    KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
                storageCipherAlgorithm:
                    StorageCipherAlgorithm.AES_GCM_NoPadding,
              ),
            ),
          ),
        ],
      );

      var context = rootNavigatorKey.currentState!.context;

      await ref.read(notiTokenControllerProvider.notifier).refresh(token);
      if (!context.mounted) return;
      StreamChat.of(context).client.addDevice(
            token,
            PushProvider.firebase,
            pushProviderName: 'Firebase',
          );
    });
  }
}
