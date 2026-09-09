// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../models/basic_response.dart';
import '../../../../models/device_token_in.dart';
import '../../../../models/notification_out.dart';
import '../../../../models/server_config_out.dart';

abstract class U2V0dGluZ3NSZXBv {
  Future<ServerConfigOut> z2V0QXBpVjFDb25maWc();

  Future<DeviceTokenIn> cG9zdEFwaVYxQ29uZmlnRmNtVg9rZw4({
    required DeviceTokenIn body,
  });

  Future<BasicResponse> zGVsZXRlQXBpVjFDb25maWdMb2dvdXQ({
    required String deviceUuid,
  });

  Future<List<NotificationOut>> z2V0QXBpVjFDb25maWdOb3RpZmljYXRpb25z();

  Future<String> z2V0QXBpVjFDb25maWdHzxrTdHJlYw1DaGf0Vg9rZw4({
    required String userUuid,
  });

  Future<BasicResponse> zGVsZXRlQXBpVjFDb25maWdOb3RpZmljYXRpb25VdWlk({
    required int notificationUuid,
  });
}
