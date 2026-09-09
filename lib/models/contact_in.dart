// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_in.freezed.dart';
part 'contact_in.g.dart';

@Freezed()
abstract class ContactIn with _$ContactIn {
  const factory ContactIn({
    required String value,
    required String type,
    String? uuid,
  }) = _ContactIn;

  factory ContactIn.fromJson(Map<String, Object?> json) =>
      _$ContactInFromJson(json);
}
