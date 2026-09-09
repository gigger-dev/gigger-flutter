// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile_fewer_details_out.dart';

part 'line_up_and_performer_out.freezed.dart';
part 'line_up_and_performer_out.g.dart';

@Freezed()
abstract class LineUpAndPerformerOut with _$LineUpAndPerformerOut {
  const factory LineUpAndPerformerOut({
    @JsonKey(name: 'profile_uuid') required String profileUuid,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') required DateTime endTime,
    required int id,
    @JsonKey(name: 'event_uuid') required String eventUuid,
    @JsonKey(name: 'is_accepted') required bool isAccepted,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    required ProfileFewerDetailsOut profile,
  }) = _LineUpAndPerformerOut;

  factory LineUpAndPerformerOut.fromJson(Map<String, Object?> json) =>
      _$LineUpAndPerformerOutFromJson(json);
}
