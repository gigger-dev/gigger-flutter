// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'gig_list_metadata.freezed.dart';
part 'gig_list_metadata.g.dart';

@Freezed()
abstract class GigListMetadata with _$GigListMetadata {
  const factory GigListMetadata({
    @JsonKey(name: 'has_already_given_star') required bool hasAlreadyGivenStar,
    @JsonKey(name: 'star_count') required int starCount,
    @JsonKey(name: 'has_already_liked') required bool hasAlreadyLiked,
    @JsonKey(name: 'like_count') required int likeCount,
  }) = _GigListMetadata;

  factory GigListMetadata.fromJson(Map<String, Object?> json) =>
      _$GigListMetadataFromJson(json);
}
