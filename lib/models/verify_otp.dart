// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp.freezed.dart';
part 'verify_otp.g.dart';

@Freezed()
abstract class VerifyOtp with _$VerifyOtp {
  const factory VerifyOtp({
    required String email,
    required String otp,
  }) = _VerifyOtp;

  factory VerifyOtp.fromJson(Map<String, Object?> json) =>
      _$VerifyOtpFromJson(json);
}
