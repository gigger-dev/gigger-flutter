// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement_in.freezed.dart';
part 'achievement_in.g.dart';

@Freezed()
abstract class AchievementIn with _$AchievementIn {
  const factory AchievementIn({
    required String name,
    required String category,
    required String? url,
    String? uuid,
  }) = _AchievementIn;

  factory AchievementIn.fromJson(Map<String, Object?> json) =>
      _$AchievementInFromJson(json);
}
