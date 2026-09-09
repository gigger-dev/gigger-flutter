// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_out.freezed.dart';
part 'account_out.g.dart';

@Freezed()
abstract class AccountOut with _$AccountOut {
  const factory AccountOut({
    required String username,
    required String email,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'date_of_birth') required DateTime dateOfBirth,
    @JsonKey(name: 'email_verified') required bool emailVerified,
    required String uuid,
  }) = _AccountOut;

  factory AccountOut.fromJson(Map<String, Object?> json) =>
      _$AccountOutFromJson(json);
}
