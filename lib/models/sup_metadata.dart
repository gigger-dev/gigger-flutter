// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sup_metadata.freezed.dart';
part 'sup_metadata.g.dart';

@Freezed()
abstract class SupMetadata with _$SupMetadata {
  const factory SupMetadata({
    @JsonKey(name: 'has_already_liked') required bool hasAlreadyLiked,
    @JsonKey(name: 'like_count') required int likeCount,
    @JsonKey(name: 'has_already_shared') required bool hasAlreadyShared,
    @JsonKey(name: 'share_count') required int shareCount,
    @JsonKey(name: 'has_already_viewed') required bool hasAlreadyViewed,
    @JsonKey(name: 'view_count') required int viewCount,
  }) = _SupMetadata;

  factory SupMetadata.fromJson(Map<String, Object?> json) =>
      _$SupMetadataFromJson(json);
}
