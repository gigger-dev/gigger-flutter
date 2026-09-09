// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hash_tag.dart';

part 'post_create.freezed.dart';
part 'post_create.g.dart';

@Freezed()
abstract class PostCreate with _$PostCreate {
  const factory PostCreate({
    @JsonKey(name: 'post_title') required String postTitle,
    required String caption,
    @JsonKey(name: 'music_title') required String musicTitle,
    @JsonKey(name: 'profile_uuid') required String profileUuid,
    @JsonKey(name: 'is_private') required bool isPrivate,
    @JsonKey(name: 'is_membership_only') required bool isMembershipOnly,
    @JsonKey(name: 'is_only_for_followers') required bool isOnlyForFollowers,
    @JsonKey(name: 'video_url') required String videoUrl,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
    required List<HashTag> hashtags,
    @JsonKey(name: 'tagged_profiles') required List<String> taggedProfiles,
    required String location,
    @JsonKey(name: 'is_draft') @Default(false) bool isDraft,
    num? lat,
    num? long,
  }) = _PostCreate;

  factory PostCreate.fromJson(Map<String, Object?> json) =>
      _$PostCreateFromJson(json);
}
