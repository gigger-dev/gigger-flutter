// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_position_metadata.freezed.dart';
part 'post_position_metadata.g.dart';

@Freezed()
abstract class PostPositionMetadata with _$PostPositionMetadata {
  const factory PostPositionMetadata({
    @JsonKey(name: 'profile_uuid') required String profileUuid,

    /// Mapping of positions (1-9) to post UUIDs
    required Map<String, String> layout,
  }) = _PostPositionMetadata;

  factory PostPositionMetadata.fromJson(Map<String, Object?> json) =>
      _$PostPositionMetadataFromJson(json);
}
