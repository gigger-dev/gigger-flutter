// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile_out.dart';

part 'paginated_response_profile_out.freezed.dart';
part 'paginated_response_profile_out.g.dart';

@Freezed()
abstract class PaginatedResponseProfileOut with _$PaginatedResponseProfileOut {
  const factory PaginatedResponseProfileOut({
    required int offset,
    required int total,
    required List<ProfileOut> items,
    @Default(50) int limit,
  }) = _PaginatedResponseProfileOut;

  factory PaginatedResponseProfileOut.fromJson(Map<String, Object?> json) =>
      _$PaginatedResponseProfileOutFromJson(json);
}
