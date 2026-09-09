// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_config_out.freezed.dart';
part 'server_config_out.g.dart';

@Freezed()
abstract class ServerConfigOut with _$ServerConfigOut {
  const factory ServerConfigOut({
    @JsonKey(name: 'base_url') required String baseUrl,
    @JsonKey(name: 'cdn_url') required String cdnUrl,
  }) = _ServerConfigOut;

  factory ServerConfigOut.fromJson(Map<String, Object?> json) =>
      _$ServerConfigOutFromJson(json);
}
