// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'call_to_action.dart';
import 'gig_list_media.dart';
import 'hash_tag.dart';

part 'gig_list_update.freezed.dart';
part 'gig_list_update.g.dart';

@Freezed()
abstract class GigListUpdate with _$GigListUpdate {
  const factory GigListUpdate({
    required String uuid,
    @JsonKey(name: 'wage_requested') required num? wageRequested,

    /// Gig list media, key is int and  position of media
    @JsonKey(name: 'gig_list_media')
    required Map<String, GigListMedia> gigListMedia,
    String? title,
    String? description,
    String? location,
    num? lat,
    num? long,
    List<HashTag>? hashtags,
    @JsonKey(name: 'is_looking_for') bool? isLookingFor,
    @JsonKey(name: 'is_performer') bool? isPerformer,
    @JsonKey(name: 'add_call_to_action') bool? addCallToAction,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @JsonKey(name: 'call_to_action') CallToAction? callToAction,
  }) = _GigListUpdate;

  factory GigListUpdate.fromJson(Map<String, Object?> json) =>
      _$GigListUpdateFromJson(json);
}
