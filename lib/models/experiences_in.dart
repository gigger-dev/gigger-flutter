// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'experiences_in.freezed.dart';
part 'experiences_in.g.dart';

@Freezed()
abstract class ExperiencesIn with _$ExperiencesIn {
  const factory ExperiencesIn({
    required String name,
    required String category,
    String? uuid,
  }) = _ExperiencesIn;

  factory ExperiencesIn.fromJson(Map<String, Object?> json) =>
      _$ExperiencesInFromJson(json);
}
