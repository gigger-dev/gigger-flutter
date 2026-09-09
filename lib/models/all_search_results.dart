// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'gig_list_out.dart';
import 'post_out.dart';
import 'profile_out.dart';

part 'all_search_results.freezed.dart';
part 'all_search_results.g.dart';

@Freezed()
abstract class AllSearchResults with _$AllSearchResults {
  const factory AllSearchResults({
    required List<ProfileOut> profiles,
    required List<PostOut> posts,
    @JsonKey(name: 'gig_list') required List<GigListOut> gigList,
    required List<dynamic> events,
    required List<dynamic> services,
    required List<dynamic> campaigns,
  }) = _AllSearchResults;

  factory AllSearchResults.fromJson(Map<String, Object?> json) =>
      _$AllSearchResultsFromJson(json);
}
