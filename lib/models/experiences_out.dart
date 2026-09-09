// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'experiences_out.freezed.dart';
part 'experiences_out.g.dart';

@Freezed()
abstract class ExperiencesOut with _$ExperiencesOut {
  const factory ExperiencesOut({
    required String name,
    required String category,
    String? uuid,
  }) = _ExperiencesOut;

  factory ExperiencesOut.fromJson(Map<String, Object?> json) =>
      _$ExperiencesOutFromJson(json);
}
