// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_out.freezed.dart';
part 'contact_out.g.dart';

@Freezed()
abstract class ContactOut with _$ContactOut {
  const factory ContactOut({
    required String value,
    required String type,
    String? uuid,
  }) = _ContactOut;

  factory ContactOut.fromJson(Map<String, Object?> json) =>
      _$ContactOutFromJson(json);
}
