// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement_out.freezed.dart';
part 'achievement_out.g.dart';

@Freezed()
abstract class AchievementOut with _$AchievementOut {
  const factory AchievementOut({
    required String name,
    required String uuid,
    required String category,
    required String? url,
  }) = _AchievementOut;

  factory AchievementOut.fromJson(Map<String, Object?> json) =>
      _$AchievementOutFromJson(json);
}
