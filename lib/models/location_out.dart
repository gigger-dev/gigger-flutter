// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_out.freezed.dart';
part 'location_out.g.dart';

@Freezed()
abstract class LocationOut with _$LocationOut {
  const factory LocationOut({
    required String? address,
    required String country,
    required String city,
    required String state,
    required String uuid,
  }) = _LocationOut;

  factory LocationOut.fromJson(Map<String, Object?> json) =>
      _$LocationOutFromJson(json);
}
