// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_out.freezed.dart';
part 'notification_out.g.dart';

@Freezed()
abstract class NotificationOut with _$NotificationOut {
  const factory NotificationOut({
    required String title,
    required String body,
    required dynamic data,
    @JsonKey(name: 'notification_type') required int notificationType,
    @JsonKey(name: 'profile_uuid') required String profileUuid,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    required int id,
  }) = _NotificationOut;

  factory NotificationOut.fromJson(Map<String, Object?> json) =>
      _$NotificationOutFromJson(json);
}
