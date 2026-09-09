// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_out.freezed.dart';
part 'token_out.g.dart';

@Freezed()
abstract class TokenOut with _$TokenOut {
  const factory TokenOut({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _TokenOut;

  factory TokenOut.fromJson(Map<String, Object?> json) =>
      _$TokenOutFromJson(json);
}
