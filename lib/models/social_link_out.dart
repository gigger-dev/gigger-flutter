// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'social_links.dart';

part 'social_link_out.freezed.dart';
part 'social_link_out.g.dart';

@Freezed()
abstract class SocialLinkOut with _$SocialLinkOut {
  const factory SocialLinkOut({
    required SocialLinks type,
    required String url,
    String? uuid,
  }) = _SocialLinkOut;

  factory SocialLinkOut.fromJson(Map<String, Object?> json) =>
      _$SocialLinkOutFromJson(json);
}
