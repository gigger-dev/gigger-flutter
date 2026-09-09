// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum FileType {
  @JsonValue('profile')
  profile('profile'),
  @JsonValue('cover')
  cover('cover'),
  @JsonValue('media')
  media('media'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const FileType(this.json);

  factory FileType.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
