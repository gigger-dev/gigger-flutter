// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'simple_response.freezed.dart';
part 'simple_response.g.dart';

@Freezed()
abstract class SimpleResponse with _$SimpleResponse {
  const factory SimpleResponse({
    @JsonKey(name: 'status_code') required int statusCode,
    required String message,
    required dynamic extra,
  }) = _SimpleResponse;

  factory SimpleResponse.fromJson(Map<String, Object?> json) =>
      _$SimpleResponseFromJson(json);
}
