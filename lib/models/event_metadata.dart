// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile_fewer_details_out.dart';

part 'event_metadata.freezed.dart';
part 'event_metadata.g.dart';

@Freezed()
abstract class EventMetadata with _$EventMetadata {
  const factory EventMetadata({
    @JsonKey(name: 'has_already_viewed') required bool hasAlreadyViewed,
    @JsonKey(name: 'has_already_liked') required bool hasAlreadyLiked,
    @JsonKey(name: 'like_count') required int likeCount,
    @JsonKey(name: 'response_type') required int responseType,
    @JsonKey(name: 'total_going_response') required int totalGoingResponse,
    @JsonKey(name: 'going_profile')
    required List<ProfileFewerDetailsOut> goingProfile,
  }) = _EventMetadata;

  factory EventMetadata.fromJson(Map<String, Object?> json) =>
      _$EventMetadataFromJson(json);
}
