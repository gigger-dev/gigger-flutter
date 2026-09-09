// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'post_out.dart';

part 'paginated_response_post_out.freezed.dart';
part 'paginated_response_post_out.g.dart';

@Freezed()
abstract class PaginatedResponsePostOut with _$PaginatedResponsePostOut {
  const factory PaginatedResponsePostOut({
    required int offset,
    required int total,
    required List<PostOut> items,
    @Default(50) int limit,
  }) = _PaginatedResponsePostOut;

  factory PaginatedResponsePostOut.fromJson(Map<String, Object?> json) =>
      _$PaginatedResponsePostOutFromJson(json);
}
