import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_gigger_app/core/helpers/chat_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as m;

import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/route/router_config.dart';
import 'package:mobile_gigger_app/core/utils/create_circle_image.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/hash_tag.dart';
import 'package:mobile_gigger_app/models/post_form_extra.dart';

bool isFlutterLocalNotificationsInitialized = false;

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class NotificationHelper {
  static Future<void> initialize({bool requestPermission = true}) async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    channel = const AndroidNotificationChannel(
      'system_notifications',
      'System Notifications',
      description: 'This channel is used for system notifications.',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    var androidImplement =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplement?.createNotificationChannel(channel);

    if (requestPermission) {
      await androidImplement?.requestNotificationsPermission();
    }

    isFlutterLocalNotificationsInitialized = true;
  }

  static Future<void> showMessageNoti(m.Message message) async {
    await _showTextNotification(
      message.id.hashCode,
      message.user!.name,
      message.text!,
      {},
    );
  }

  static Future<void> _showStreamChatNoti(RemoteMessage message) async {
    var data = message.data;

    log(jsonEncode(data));

    var messageId = data['message_id'];

    var client = await ChatHelper.getClient(data['receiver_id']);
    var r = await client.getMessage(messageId);

    await _showWithImage(
      r.message.id.hashCode,
      null,
      r.message.text,
      r.message.user?.name,
      r.message.user?.image,
      fullImg: true,
      groupKey: data['channel_type'],
      payload: jsonEncode(data),
    );
  }

  static Future<void> show(RemoteMessage message) async {
    if (message.data.containsKey('sender')) {
      return _showStreamChatNoti(message);
    }

    final notification = message.notification;
    if (notification == null) return;

    var android = message.notification?.android;
    if (android == null) return;

    var data = message.data;

    if (data.isNotEmpty) {
      var name = data['profile_name'];
      var image = data['profile_image'];

      return _showWithImage(
        message.messageId.hashCode,
        notification.title,
        notification.body,
        name,
        image,
      );
    }

    await _showTextNotification(
      message.messageId.hashCode,
      notification.title,
      notification.body,
      data,
    );
  }

  static Future<void> _showTextNotification(
    int id,
    String? title,
    String? body,
    Map<String, dynamic> data,
  ) async {
    var details = NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        priority: Priority.max,
        importance: Importance.max,
        channelDescription: channel.description,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: jsonEncode(data),
    );
  }

  static Future<void> showFakeNoti() async {
    await _showWithImage(
      0,
      'New Follower',
      'Htun Thandar followed you!',
      'Htun Thandar',
      'PROFILE/f257943f-3456-4624-a941-d5ef50248859/scaled_1000018817.jpg',
    );
  }

  static Future<void> _showWithImage(
    int id,
    String? title,
    String? body,
    name,
    image, {
    String? payload,
    bool fullImg = false,
    String groupKey = 'friend_request',
  }) async {
    var ref = ProviderContainer(
      overrides: [
        secureStorageProvider.overrideWithValue(FlutterSecureStorage(
          aOptions: AndroidOptions(
            keyCipherAlgorithm:
                KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
            storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
          ),
        )),
      ],
    );
    var config = await ref.read(configProvider.future);

    String? bigPicturePath = image == null
        ? null
        : await _downloadAndSaveFile(
            fullImg ? image : '${config?.cdnUrl}/$image',
            p.basename(image),
          );

    var person = Person(
      name: name,
      important: true,
      icon: bigPicturePath == null
          ? null
          : BitmapFilePathAndroidIcon(bigPicturePath),
    );

    var details = NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        groupKey: groupKey,
        priority: Priority.high,
        importance: Importance.high,
        channelDescription: channel.description,
        category: AndroidNotificationCategory.message,
        styleInformation: MessagingStyleInformation(
          person,
          conversationTitle: title,
          groupConversation: true,
          messages: [
            Message(body ?? '', DateTime.now(), person),
          ],
        ),
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      null,
      null,
      details,
      payload: payload,
    );
  }

  static Future<void> showProgress({
    required int id,
    String? title,
    String? body,
    required double progress,
  }) async {
    var details = NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        silent: true,
        ongoing: true,
        playSound: false,
        maxProgress: 100,
        showProgress: true,
        enableVibration: false,
        icon: '@mipmap/ic_launcher',
        progress: (progress * 100).toInt(),
        channelDescription: channel.description,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: 'form',
    );
  }

  static Future<void> showError({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) async {
    var details = NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        playSound: false,
        priority: Priority.max,
        importance: Importance.max,
        icon: '@mipmap/ic_launcher',
        channelDescription: channel.description,
        actions: [
          AndroidNotificationAction(
            'retry_action',
            'Retry',
            showsUserInterface: true,
            cancelNotification: false,
          ),
        ],
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  static Future<void> showDone({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) async {
    var details = NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        playSound: false,
        priority: Priority.max,
        enableVibration: false,
        importance: Importance.max,
        icon: '@mipmap/ic_launcher',
        channelDescription: channel.description,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: 'form',
    );
  }

  static Future<String> _downloadAndSaveFile(
    String url,
    String fileName,
  ) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';

    if (File(filePath).existsSync()) return filePath;

    final Response response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));

    var bytes = await createCircularImage(response.data, 100);

    final File file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }

  static void _onDidReceiveNotificationResponse(NotificationResponse details) {
    if (details.actionId == 'retry_action') {
      var data = jsonDecode(details.payload ?? '{}') as Map<String, dynamic>;

      if (data.containsKey('line_up_n_performers_out')) {
        return EventFormRoute($extra: EventOut.fromJson(data))
            .go(rootNavigatorKey.currentContext!);
      }

      var uuid = data['uuid'] as String?;
      var location = data['location'] as String?;
      var title = data['title'] as String;
      var caption = data['caption'] as String;
      var musicTitle = data['musicTitle'] as String;
      var wageRequested = data['wageRequested'] as int;
      var tags = List<HashTag>.from(
        (data['tags'] as List).map((e) => HashTag.fromJson(e)),
      );

      return PostFormRoute(
        uuid: uuid,
        title: title,
        caption: caption,
        place: location,
        musicTitle: musicTitle,
        wageRequested: wageRequested,
        $extra: PostFormExtra(payload: data, hashtags: tags),
      ).go(rootNavigatorKey.currentContext!);
    }

    try {
      var payload = jsonDecode(details.payload ?? '{}') as Map;

      if (payload.containsKey('sender')) {
        return ChatRoute(
          type: payload['channel_type'],
          channelId: payload['channel_id'],
        ).go(rootNavigatorKey.currentContext!);
      }
    } catch (_) {}

    if (details.payload == 'form' || (details.payload?.length ?? 0) > 20) {
      return MainRoute().go(rootNavigatorKey.currentContext!);
    }

    NotiRoute().go(rootNavigatorKey.currentContext!);
    // ConnectionRoute().go(rootNavigatorKey.currentContext!);
  }
}
