// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_in.freezed.dart';
part 'location_in.g.dart';

@Freezed()
abstract class LocationIn with _$LocationIn {
  const factory LocationIn({
    required String? address,
    required String country,
    required String city,
    required String state,
  }) = _LocationIn;

  factory LocationIn.fromJson(Map<String, Object?> json) =>
      _$LocationInFromJson(json);
}
