// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password.freezed.dart';
part 'forgot_password.g.dart';

@Freezed()
abstract class ForgotPassword with _$ForgotPassword {
  const factory ForgotPassword({
    required String password,
    @JsonKey(name: 'confirm_password') required String confirmPassword,
  }) = _ForgotPassword;

  factory ForgotPassword.fromJson(Map<String, Object?> json) =>
      _$ForgotPasswordFromJson(json);
}
