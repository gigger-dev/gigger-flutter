// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'gig_list_out.dart';

part 'paginated_response_gig_list_out.freezed.dart';
part 'paginated_response_gig_list_out.g.dart';

@Freezed()
abstract class PaginatedResponseGigListOut with _$PaginatedResponseGigListOut {
  const factory PaginatedResponseGigListOut({
    required int offset,
    required int total,
    required List<GigListOut> items,
    @Default(50) int limit,
  }) = _PaginatedResponseGigListOut;

  factory PaginatedResponseGigListOut.fromJson(Map<String, Object?> json) =>
      _$PaginatedResponseGigListOutFromJson(json);
}
