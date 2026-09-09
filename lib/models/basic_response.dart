// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_response.freezed.dart';
part 'basic_response.g.dart';

@Freezed()
abstract class BasicResponse with _$BasicResponse {
  const factory BasicResponse({
    required String message,
    @Default(true) bool success,
  }) = _BasicResponse;

  factory BasicResponse.fromJson(Map<String, Object?> json) =>
      _$BasicResponseFromJson(json);
}
