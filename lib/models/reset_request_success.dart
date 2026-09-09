// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_request_success.freezed.dart';
part 'reset_request_success.g.dart';

@Freezed()
abstract class ResetRequestSuccess with _$ResetRequestSuccess {
  const factory ResetRequestSuccess({
    required String email,
    @JsonKey(name: 'session_token') required String sessionToken,
  }) = _ResetRequestSuccess;

  factory ResetRequestSuccess.fromJson(Map<String, Object?> json) =>
      _$ResetRequestSuccessFromJson(json);
}
