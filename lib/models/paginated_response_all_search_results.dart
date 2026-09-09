// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'all_search_results.dart';

part 'paginated_response_all_search_results.freezed.dart';
part 'paginated_response_all_search_results.g.dart';

@Freezed()
class PaginatedResponseAllSearchResults
    with _$PaginatedResponseAllSearchResults {
  const factory PaginatedResponseAllSearchResults({
    required int offset,
    required int total,
    required List<AllSearchResults> items,
    @Default(50) int limit,
  }) = _PaginatedResponseAllSearchResults;

  factory PaginatedResponseAllSearchResults.fromJson(
          Map<String, Object?> json) =>
      _$PaginatedResponseAllSearchResultsFromJson(json);
}
