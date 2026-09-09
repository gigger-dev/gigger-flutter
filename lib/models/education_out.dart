// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'education_out.freezed.dart';
part 'education_out.g.dart';

@Freezed()
abstract class EducationOut with _$EducationOut {
  const factory EducationOut({
    required String name,
    required String? url,
    String? uuid,
  }) = _EducationOut;

  factory EducationOut.fromJson(Map<String, Object?> json) =>
      _$EducationOutFromJson(json);
}
