// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'gig_list_media.freezed.dart';
part 'gig_list_media.g.dart';

@Freezed()
abstract class GigListMedia with _$GigListMedia {
  const factory GigListMedia({
    @JsonKey(name: 'media_url') required String mediaUrl,
    @JsonKey(name: 'is_video') required bool isVideo,
  }) = _GigListMedia;

  factory GigListMedia.fromJson(Map<String, Object?> json) =>
      _$GigListMediaFromJson(json);
}
