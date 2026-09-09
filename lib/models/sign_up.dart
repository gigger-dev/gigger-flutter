// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up.freezed.dart';
part 'sign_up.g.dart';

@Freezed()
abstract class SignUp with _$SignUp {
  const factory SignUp({
    required String email,
    required String password,
    required String username,
    @JsonKey(name: 'confirm_password') required String confirmPassword,
    @JsonKey(name: 'date_of_birth') required DateTime dateOfBirth,
  }) = _SignUp;

  factory SignUp.fromJson(Map<String, Object?> json) => _$SignUpFromJson(json);
}
