// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hash_tag.dart';
import 'profile_out.dart';
import 'sup_created_from_enum.dart';

part 'sup_out.freezed.dart';
part 'sup_out.g.dart';

@Freezed()
abstract class SupOut with _$SupOut {
  const factory SupOut({
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
    required String uuid,
    @JsonKey(name: 'tagged_profiles_details')
    required List<ProfileOut> taggedProfilesDetails,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'is_already_seen') required bool isAlreadySeen,
    num? lat,
    num? long,
  }) = _SupOut;

  factory SupOut.fromJson(Map<String, Object?> json) => _$SupOutFromJson(json);
}
