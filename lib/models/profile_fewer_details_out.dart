// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'account_fewer_details_out.dart';
import 'location_out.dart';

part 'profile_fewer_details_out.freezed.dart';
part 'profile_fewer_details_out.g.dart';

@Freezed()
abstract class ProfileFewerDetailsOut with _$ProfileFewerDetailsOut {
  const factory ProfileFewerDetailsOut({
    required String uuid,
    @JsonKey(name: 'account_uuid') required String accountUuid,
    @JsonKey(name: 'cover_media') required String coverMedia,
    @JsonKey(name: 'avatar_media') required String avatarMedia,
    required AccountFewerDetailsOut account,
    @JsonKey(name: 'is_private_profile') required bool isPrivateProfile,
    required LocationOut location,
    @JsonKey(name: 'is_followed_back') bool? isFollowedBack,
    @JsonKey(name: 'is_follow_request_already_sent')
    bool? isFollowRequestAlreadySent,
  }) = _ProfileFewerDetailsOut;

  factory ProfileFewerDetailsOut.fromJson(Map<String, Object?> json) =>
      _$ProfileFewerDetailsOutFromJson(json);
}
