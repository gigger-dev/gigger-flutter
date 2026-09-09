// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password.freezed.dart';
part 'reset_password.g.dart';

@Freezed()
abstract class ResetPassword with _$ResetPassword {
  const factory ResetPassword({
    @JsonKey(name: 'old_password') required String oldPassword,
    required String password,
    @JsonKey(name: 'confirm_password') required String confirmPassword,
  }) = _ResetPassword;

  factory ResetPassword.fromJson(Map<String, Object?> json) =>
      _$ResetPasswordFromJson(json);
}
