// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability_out.freezed.dart';
part 'availability_out.g.dart';

@Freezed()
abstract class AvailabilityOut with _$AvailabilityOut {
  const factory AvailabilityOut({
    required int day,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    String? uuid,
  }) = _AvailabilityOut;

  factory AvailabilityOut.fromJson(Map<String, Object?> json) =>
      _$AvailabilityOutFromJson(json);
}
