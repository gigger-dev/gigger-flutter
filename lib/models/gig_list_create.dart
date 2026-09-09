// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'call_to_action.dart';
import 'gig_list_media.dart';
import 'hash_tag.dart';

part 'gig_list_create.freezed.dart';
part 'gig_list_create.g.dart';

@Freezed()
abstract class GigListCreate with _$GigListCreate {
  const factory GigListCreate({
    @JsonKey(name: 'profile_uuid') required String profileUuid,
    required String title,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,

    /// Gig list media, key is int and  position of media
    @JsonKey(name: 'gig_list_media')
    required Map<String, GigListMedia> gigListMedia,
    required String description,
    required String location,
    required List<HashTag> hashtags,
    @JsonKey(name: 'wage_requested') required num? wageRequested,
    @JsonKey(name: 'is_looking_for') required bool isLookingFor,
    @JsonKey(name: 'is_performer') required bool isPerformer,
    @JsonKey(name: 'add_call_to_action') required bool addCallToAction,
    @JsonKey(name: 'call_to_action') required CallToAction callToAction,
    num? lat,
    num? long,
  }) = _GigListCreate;

  factory GigListCreate.fromJson(Map<String, Object?> json) =>
      _$GigListCreateFromJson(json);
}
