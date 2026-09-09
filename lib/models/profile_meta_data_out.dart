// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'relationship_meta_data_out.dart';

part 'profile_meta_data_out.freezed.dart';
part 'profile_meta_data_out.g.dart';

@Freezed()
abstract class ProfileMetaDataOut with _$ProfileMetaDataOut {
  const factory ProfileMetaDataOut({
    @JsonKey(name: 'followers_count') required int followersCount,
    @JsonKey(name: 'following_count') required int followingCount,
    @JsonKey(name: 'like_count') required int likeCount,
    @JsonKey(name: 'view_count') required int viewCount,
    @JsonKey(name: 'is_self') required bool isSelf,
    @JsonKey(name: 'relationship_meta_data')
    required RelationshipMetaDataOut? relationshipMetaData,
  }) = _ProfileMetaDataOut;

  factory ProfileMetaDataOut.fromJson(Map<String, Object?> json) =>
      _$ProfileMetaDataOutFromJson(json);
}
