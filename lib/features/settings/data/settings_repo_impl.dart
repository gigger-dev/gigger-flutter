// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../models/basic_response.dart';
import '../../../../models/device_token_in.dart';
import '../../../../models/notification_out.dart';
import '../../../../models/server_config_out.dart';

import '../domain/settings_repo.dart';
import '../../../../../gen/c2_v0d_glu_z3_nf_y2xp_zw50.dart';

class U2V0dGluZ3NSZXBvSW1wbA implements U2V0dGluZ3NSZXBv {
  U2V0dGluZ3NSZXBvSW1wbA(this.client);

  final U2V0dGluZ3NDbGllbnQ client;

  @override
  Future<ServerConfigOut> z2V0QXBpVjFDb25maWc() {
    return client.z2V0QXBpVjFDb25maWc();
  }

  @override
  Future<DeviceTokenIn> cG9zdEFwaVYxQ29uZmlnRmNtVg9rZw4({
    required DeviceTokenIn body,
  }) {
    return client.cG9zdEFwaVYxQ29uZmlnRmNtVg9rZw4(
      body: body,
    );
  }

  @override
  Future<BasicResponse> zGVsZXRlQXBpVjFDb25maWdMb2dvdXQ({
    required String deviceUuid,
  }) {
    return client.zGVsZXRlQXBpVjFDb25maWdMb2dvdXQ(
      deviceUuid: deviceUuid,
    );
  }

  @override
  Future<List<NotificationOut>> z2V0QXBpVjFDb25maWdOb3RpZmljYXRpb25z() {
    return client.z2V0QXBpVjFDb25maWdOb3RpZmljYXRpb25z();
  }

  @override
  Future<String> z2V0QXBpVjFDb25maWdHzxrTdHJlYw1DaGf0Vg9rZw4({
    required String userUuid,
  }) {
    return client.z2V0QXBpVjFDb25maWdHzxrTdHJlYw1DaGf0Vg9rZw4(
      userUuid: userUuid,
    );
  }

  @override
  Future<BasicResponse> zGVsZXRlQXBpVjFDb25maWdOb3RpZmljYXRpb25VdWlk({
    required int notificationUuid,
  }) {
    return client.zGVsZXRlQXBpVjFDb25maWdOb3RpZmljYXRpb25VdWlk(
      notificationUuid: notificationUuid,
    );
  }
}
