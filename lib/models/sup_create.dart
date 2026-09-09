// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hash_tag.dart';
import 'sup_created_from_enum.dart';

part 'sup_create.freezed.dart';
part 'sup_create.g.dart';

@Freezed()
abstract class SupCreate with _$SupCreate {
  const factory SupCreate({
    required String caption,
    @JsonKey(name: 'video_url') required String videoUrl,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
    required List<HashTag> hashtags,
    @JsonKey(name: 'is_membership_only') required bool isMembershipOnly,
    @JsonKey(name: 'is_only_for_followers') required bool isOnlyForFollowers,
    @JsonKey(name: 'tagged_profiles') required List<String> taggedProfiles,
    required String location,
    @JsonKey(name: 'profile_uuid') required String profileUuid,
    @JsonKey(name: 'create_from') required SupCreatedFromEnum createFrom,
    num? lat,
    num? long,
  }) = _SupCreate;

  factory SupCreate.fromJson(Map<String, Object?> json) =>
      _$SupCreateFromJson(json);
}
