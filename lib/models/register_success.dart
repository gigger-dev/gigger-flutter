// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_success.freezed.dart';
part 'register_success.g.dart';

@Freezed()
abstract class RegisterSuccess with _$RegisterSuccess {
  const factory RegisterSuccess({
    required String email,
    @JsonKey(name: 'session_token') required String sessionToken,
  }) = _RegisterSuccess;

  factory RegisterSuccess.fromJson(Map<String, Object?> json) =>
      _$RegisterSuccessFromJson(json);
}
