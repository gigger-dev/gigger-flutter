// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum SocialLinks {
  @JsonValue('facebook')
  facebook('facebook'),
  @JsonValue('x')
  x('x'),
  @JsonValue('instagram')
  instagram('instagram'),
  @JsonValue('linkedin')
  linkedin('linkedin'),
  @JsonValue('github')
  github('github'),
  @JsonValue('discord')
  discord('discord'),
  @JsonValue('telegram')
  telegram('telegram'),
  @JsonValue('tiktok')
  tiktok('tiktok'),
  @JsonValue('youtube')
  youtube('youtube'),
  @JsonValue('twitch')
  twitch('twitch'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const SocialLinks(this.json);

  factory SocialLinks.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
