// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum SupCreatedFromEnum {
  @JsonValue('POST')
  post('POST'),
  @JsonValue('GIG_LIST')
  gigList('GIG_LIST'),
  @JsonValue('ARTIST')
  artist('ARTIST'),
  @JsonValue('EVENT')
  event('EVENT'),
  @JsonValue('PRO_SERVICE')
  proService('PRO_SERVICE'),
  @JsonValue('CAMPAIGN')
  campaign('CAMPAIGN'),
  @JsonValue('MEMBERSHIP')
  membership('MEMBERSHIP'),
  @JsonValue('NONE')
  none('NONE'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const SupCreatedFromEnum(this.json);

  factory SupCreatedFromEnum.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
}
