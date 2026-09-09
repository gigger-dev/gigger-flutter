// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../models/basic_response.dart';
import '../../../../models/device_token_in.dart';
import '../../../../models/notification_out.dart';
import '../../../../models/server_config_out.dart';

import 'settings_repo.dart';

Future<ServerConfigOut> getApiV1ConfigUseCase(
  U2V0dGluZ3NSZXBv repo,
) {
  return repo.z2V0QXBpVjFDb25maWc();
}

Future<DeviceTokenIn> postApiV1ConfigFcmTokenUseCase({
  required DeviceTokenIn body,
  required U2V0dGluZ3NSZXBv repo,
}) {
  return repo.cG9zdEFwaVYxQ29uZmlnRmNtVg9rZw4(
    body: body,
  );
}

Future<BasicResponse> deleteApiV1ConfigLogoutUseCase({
  required String deviceUuid,
  required U2V0dGluZ3NSZXBv repo,
}) {
  return repo.zGVsZXRlQXBpVjFDb25maWdMb2dvdXQ(
    deviceUuid: deviceUuid,
  );
}

Future<List<NotificationOut>> getApiV1ConfigNotificationsUseCase(
  U2V0dGluZ3NSZXBv repo,
) {
  return repo.z2V0QXBpVjFDb25maWdOb3RpZmljYXRpb25z();
}

Future<String> getApiV1ConfigGetStreamChatTokenUseCase({
  required String userUuid,
  required U2V0dGluZ3NSZXBv repo,
}) {
  return repo.z2V0QXBpVjFDb25maWdHzxrTdHJlYw1DaGf0Vg9rZw4(
    userUuid: userUuid,
  );
}

Future<BasicResponse> deleteApiV1ConfigNotificationUuidUseCase({
  required int notificationUuid,
  required U2V0dGluZ3NSZXBv repo,
}) {
  return repo.zGVsZXRlQXBpVjFDb25maWdOb3RpZmljYXRpb25VdWlk(
    notificationUuid: notificationUuid,
  );
}
