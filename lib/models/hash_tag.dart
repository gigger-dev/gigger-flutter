// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hash_tag.freezed.dart';
part 'hash_tag.g.dart';

@Freezed()
abstract class HashTag with _$HashTag {
  const factory HashTag({
    required String name,
    String? uuid,
  }) = _HashTag;

  factory HashTag.fromJson(Map<String, Object?> json) =>
      _$HashTagFromJson(json);
}
