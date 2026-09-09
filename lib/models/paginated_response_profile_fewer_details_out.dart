// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile_fewer_details_out.dart';

part 'paginated_response_profile_fewer_details_out.freezed.dart';
part 'paginated_response_profile_fewer_details_out.g.dart';

@Freezed()
abstract class PaginatedResponseProfileFewerDetailsOut
    with _$PaginatedResponseProfileFewerDetailsOut {
  const factory PaginatedResponseProfileFewerDetailsOut({
    required int offset,
    required int total,
    required List<ProfileFewerDetailsOut> items,
    @Default(50) int limit,
  }) = _PaginatedResponseProfileFewerDetailsOut;

  factory PaginatedResponseProfileFewerDetailsOut.fromJson(
          Map<String, Object?> json) =>
      _$PaginatedResponseProfileFewerDetailsOutFromJson(json);
}
