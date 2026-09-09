// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_fewer_details_out.freezed.dart';
part 'account_fewer_details_out.g.dart';

@Freezed()
abstract class AccountFewerDetailsOut with _$AccountFewerDetailsOut {
  const factory AccountFewerDetailsOut({
    required String username,
    required String uuid,
  }) = _AccountFewerDetailsOut;

  factory AccountFewerDetailsOut.fromJson(Map<String, Object?> json) =>
      _$AccountFewerDetailsOutFromJson(json);
}
