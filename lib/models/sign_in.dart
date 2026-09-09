// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in.freezed.dart';
part 'sign_in.g.dart';

@Freezed()
abstract class SignIn with _$SignIn {
  const factory SignIn({
    required String email,
    required String password,
  }) = _SignIn;

  factory SignIn.fromJson(Map<String, Object?> json) => _$SignInFromJson(json);
}
