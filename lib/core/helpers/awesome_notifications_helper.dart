// import 'dart:convert';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
// import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';

// class AwesomeNotificationsHelper {
//   static Future<void> init() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: 'system_channel',
//           channelName: 'System notifications',
//           channelGroupKey: 'system_channel_group',
//           channelDescription: 'Notification channel for system notifications',
//         )
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//           channelGroupKey: 'system_channel_group',
//           channelGroupName: 'System group',
//         )
//       ],
//       debug: true,
//     );

//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         // This is just a basic example. For real apps, you must show some
//         // friendly dialog box before call the request method.
//         // This is very important to not harm the user experience
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//   }

//   static show(RemoteMessage message) {
//     final notification = message.notification;
//     if (notification == null) return;

//     var data = message.data;

//     if (data.containsKey('sender')) {
//       var img = message.notification?.android?.clickAction;

//       return _showWithImage(
//         message.messageId.hashCode,
//         null,
//         notification.body,
//         notification.title,
//         img,
//         data['receiver_id'],
//         'messaging',
//         fullImg: true,
//         groupKey: 'messaging',
//         payload: jsonEncode(data),
//       );
//     }
//   }

//   static Future<void> _showWithImage(
//     int id,
//     String? title,
//     String? body,
//     name,
//     image,
//     uuid,
//     type, {
//     String? payload,
//     bool fullImg = false,
//     String groupKey = 'friend_request',
//   }) async {
//     var ref = ProviderContainer(
//       overrides: [
//         secureStorageProvider.overrideWithValue(FlutterSecureStorage(
//           aOptions: AndroidOptions(
//             keyCipherAlgorithm:
//                 KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
//             storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
//           ),
//         )),
//       ],
//     );
//     var config = await ref.read(configProvider.future);

//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: id,
//         body: body,
//         title: title,
//         wakeUpScreen: true,
//         autoDismissible: false,
//         roundedBigPicture: true,
//         channelKey: 'system_channel',
//         groupKey: 'system_channel_group',
//         largeIcon: '${config?.cdnUrl}/$image',
//         category: NotificationCategory.Message,
//         notificationLayout: NotificationLayout.Messaging,
//       ),
//     );
//   }
// }
