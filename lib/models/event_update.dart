// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'call_to_action.dart';
import 'hash_tag.dart';
import 'line_up_and_performer_in.dart';

part 'event_update.freezed.dart';
part 'event_update.g.dart';

@Freezed()
abstract class EventUpdate with _$EventUpdate {
  const factory EventUpdate({
    required List<HashTag>? hashtags,
    @JsonKey(name: 'line_up_n_performers_to_remove')
    required List<LineUpAndPerformerIn> lineUpNPerformersToRemove,
    @JsonKey(name: 'line_up_n_performers_to_add')
    required List<LineUpAndPerformerIn> lineUpNPerformersToAdd,
    String? name,
    String? description,
    String? genre,
    String? location,
    @JsonKey(name: 'location_lat') num? locationLat,
    @JsonKey(name: 'location_lon') num? locationLon,
    @JsonKey(name: 'video_or_image_url') String? videoOrImageUrl,
    @JsonKey(name: 'online_event_link') String? onlineEventLink,
    @JsonKey(name: 'start_time') DateTime? startTime,
    @JsonKey(name: 'end_time') DateTime? endTime,
    @JsonKey(name: 'ticket_price') num? ticketPrice,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    String? currency,
    @JsonKey(name: 'call_to_action') CallToAction? callToAction,
    Map<String, String>? contacts,
    @JsonKey(name: 'social_links') Map<String, String>? socialLinks,
    @JsonKey(name: 'is_membership_content') bool? isMembershipContent,
  }) = _EventUpdate;

  factory EventUpdate.fromJson(Map<String, Object?> json) =>
      _$EventUpdateFromJson(json);
}
