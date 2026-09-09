// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_out.freezed.dart';
part 'skill_out.g.dart';

@Freezed()
abstract class SkillOut with _$SkillOut {
  const factory SkillOut({
    required String name,
    required String category,
    required String uuid,
  }) = _SkillOut;

  factory SkillOut.fromJson(Map<String, Object?> json) =>
      _$SkillOutFromJson(json);
}
