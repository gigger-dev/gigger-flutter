// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_upload_response.freezed.dart';
part 'image_upload_response.g.dart';

@Freezed()
abstract class ImageUploadResponse with _$ImageUploadResponse {
  const factory ImageUploadResponse({
    @JsonKey(name: 'status_code') required int statusCode,
    required String message,
    required dynamic extra,
    @JsonKey(name: 'image_path') required String imagePath,
  }) = _ImageUploadResponse;

  factory ImageUploadResponse.fromJson(Map<String, Object?> json) =>
      _$ImageUploadResponseFromJson(json);
}
