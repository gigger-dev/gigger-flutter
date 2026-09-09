// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_metadata.freezed.dart';
part 'post_metadata.g.dart';

@Freezed()
abstract class PostMetadata with _$PostMetadata {
  const factory PostMetadata({
    @JsonKey(name: 'has_already_viewed') required bool hasAlreadyViewed,
    @JsonKey(name: 'view_count') required int viewCount,
    @JsonKey(name: 'has_already_liked') required bool hasAlreadyLiked,
    @JsonKey(name: 'like_count') required int likeCount,
  }) = _PostMetadata;

  factory PostMetadata.fromJson(Map<String, Object?> json) =>
      _$PostMetadataFromJson(json);
}
