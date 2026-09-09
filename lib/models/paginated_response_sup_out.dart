// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'sup_out.dart';

part 'paginated_response_sup_out.freezed.dart';
part 'paginated_response_sup_out.g.dart';

@Freezed()
class PaginatedResponseSupOut with _$PaginatedResponseSupOut {
  const factory PaginatedResponseSupOut({
    required int offset,
    required int total,
    required List<SupOut> items,
    @Default(50) int limit,
  }) = _PaginatedResponseSupOut;

  factory PaginatedResponseSupOut.fromJson(Map<String, Object?> json) =>
      _$PaginatedResponseSupOutFromJson(json);
}
