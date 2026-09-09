// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'education_in.freezed.dart';
part 'education_in.g.dart';

@Freezed()
abstract class EducationIn with _$EducationIn {
  const factory EducationIn({
    required String name,
    required String? url,
    String? uuid,
  }) = _EducationIn;

  factory EducationIn.fromJson(Map<String, Object?> json) =>
      _$EducationInFromJson(json);
}
