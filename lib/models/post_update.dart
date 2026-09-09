// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hash_tag.dart';

part 'post_update.freezed.dart';
part 'post_update.g.dart';

@Freezed()
abstract class PostUpdate with _$PostUpdate {
  const factory PostUpdate({
    @JsonKey(name: 'profile_uuid') required String profileUuid,

    /// Post's uuid
    required String uuid,
    @JsonKey(name: 'post_title') String? postTitle,
    String? caption,
    @JsonKey(name: 'music_title') String? musicTitle,
    @JsonKey(name: 'is_private') bool? isPrivate,
    @JsonKey(name: 'is_membership_only') bool? isMembershipOnly,
    @JsonKey(name: 'is_only_for_followers') bool? isOnlyForFollowers,
    @JsonKey(name: 'video_url') String? videoUrl,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    List<HashTag>? hashtags,
    @JsonKey(name: 'tagged_profiles') List<String>? taggedProfiles,
    num? lat,
    num? long,
    String? location,
    @JsonKey(name: 'is_draft') bool? isDraft,
  }) = _PostUpdate;

  factory PostUpdate.fromJson(Map<String, Object?> json) =>
      _$PostUpdateFromJson(json);
}
