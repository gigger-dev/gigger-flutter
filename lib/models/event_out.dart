// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'call_to_action.dart';
import 'hash_tag.dart';
import 'line_up_and_performer_out.dart';

part 'event_out.freezed.dart';
part 'event_out.g.dart';

@Freezed()
abstract class EventOut with _$EventOut {
  const factory EventOut({
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
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
    required String uuid,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'line_up_n_performers_out')
    required List<LineUpAndPerformerOut> lineUpNPerformersOut,
  }) = _EventOut;

  factory EventOut.fromJson(Map<String, Object?> json) =>
      _$EventOutFromJson(json);
}
