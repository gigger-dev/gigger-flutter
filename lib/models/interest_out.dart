// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'interest_out.freezed.dart';
part 'interest_out.g.dart';

@Freezed()
abstract class InterestOut with _$InterestOut {
  const factory InterestOut({
    required String name,
    required String category,
    required String uuid,
  }) = _InterestOut;

  factory InterestOut.fromJson(Map<String, Object?> json) =>
      _$InterestOutFromJson(json);
}
