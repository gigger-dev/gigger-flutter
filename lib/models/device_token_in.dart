// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_token_in.freezed.dart';
part 'device_token_in.g.dart';

@Freezed()
abstract class DeviceTokenIn with _$DeviceTokenIn {
  const factory DeviceTokenIn({
    @JsonKey(name: 'fcm_token') required String fcmToken,
    @JsonKey(name: 'device_uuid') required String deviceUuid,
    @JsonKey(name: 'profile_uuid') required String profileUuid,
  }) = _DeviceTokenIn;

  factory DeviceTokenIn.fromJson(Map<String, Object?> json) =>
      _$DeviceTokenInFromJson(json);
}
