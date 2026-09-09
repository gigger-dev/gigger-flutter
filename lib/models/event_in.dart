// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'call_to_action.dart';
import 'hash_tag.dart';
import 'line_up_and_performer_in.dart';

part 'event_in.freezed.dart';
part 'event_in.g.dart';

@Freezed()
abstract class EventIn with _$EventIn {
  const factory EventIn({
    required String name,
    required String description,
    required String genre,
    required List<HashTag> hashtags,
    required String location,
    @JsonKey(name: 'location_lat') required num? locationLat,
    @JsonKey(name: 'location_lon') required num? locationLon,
    @JsonKey(name: 'online_event_link') required String? onlineEventLink,
    @JsonKey(name: 'video_or_image_url') required String videoOrImageUrl,
    @JsonKey(name: 'profile_uuid') required String profileUuid,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') required DateTime endTime,
    @JsonKey(name: 'ticket_price') required num ticketPrice,
    required String currency,
    @JsonKey(name: 'call_to_action') required CallToAction callToAction,
    required Map<String, String> contacts,
    @JsonKey(name: 'social_links') required Map<String, String> socialLinks,
    @JsonKey(name: 'is_membership_content') required bool isMembershipContent,
    @JsonKey(name: 'line_up_n_performers')
    required List<LineUpAndPerformerIn> lineUpNPerformers,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
  }) = _EventIn;

  factory EventIn.fromJson(Map<String, Object?> json) =>
      _$EventInFromJson(json);
}
