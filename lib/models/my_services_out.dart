// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_services_out.freezed.dart';
part 'my_services_out.g.dart';

@Freezed()
abstract class MyServicesOut with _$MyServicesOut {
  const factory MyServicesOut({
    required String name,
    required String uuid,
    required String category,
  }) = _MyServicesOut;

  factory MyServicesOut.fromJson(Map<String, Object?> json) =>
      _$MyServicesOutFromJson(json);
}
