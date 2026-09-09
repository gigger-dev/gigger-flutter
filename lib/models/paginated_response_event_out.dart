// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'event_out.dart';

part 'paginated_response_event_out.freezed.dart';
part 'paginated_response_event_out.g.dart';

@Freezed()
abstract class PaginatedResponseEventOut with _$PaginatedResponseEventOut {
  const factory PaginatedResponseEventOut({
    required int offset,
    required int total,
    required List<EventOut> items,
    @Default(50) int limit,
  }) = _PaginatedResponseEventOut;

  factory PaginatedResponseEventOut.fromJson(Map<String, Object?> json) =>
      _$PaginatedResponseEventOutFromJson(json);
}
