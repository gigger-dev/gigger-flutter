// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'social_links.dart';

part 'social_link_in.freezed.dart';
part 'social_link_in.g.dart';

@Freezed()
abstract class SocialLinkIn with _$SocialLinkIn {
  const factory SocialLinkIn({
    required SocialLinks type,
    required String url,
    String? uuid,
  }) = _SocialLinkIn;

  factory SocialLinkIn.fromJson(Map<String, Object?> json) =>
      _$SocialLinkInFromJson(json);
}
