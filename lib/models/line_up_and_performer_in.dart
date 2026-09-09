// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'line_up_and_performer_in.freezed.dart';
part 'line_up_and_performer_in.g.dart';

@Freezed()
abstract class LineUpAndPerformerIn with _$LineUpAndPerformerIn {
  const factory LineUpAndPerformerIn({
    @JsonKey(name: 'profile_uuid') required String profileUuid,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') required DateTime endTime,
  }) = _LineUpAndPerformerIn;

  factory LineUpAndPerformerIn.fromJson(Map<String, Object?> json) =>
      _$LineUpAndPerformerInFromJson(json);
}
