// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability_search_param.freezed.dart';
part 'availability_search_param.g.dart';

@Freezed()
class AvailabilitySearchParam with _$AvailabilitySearchParam {
  const factory AvailabilitySearchParam({
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
  }) = _AvailabilitySearchParam;

  factory AvailabilitySearchParam.fromJson(Map<String, Object?> json) =>
      _$AvailabilitySearchParamFromJson(json);
}
