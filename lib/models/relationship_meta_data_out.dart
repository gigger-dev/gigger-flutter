// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'relationship_meta_data_out.freezed.dart';
part 'relationship_meta_data_out.g.dart';

@Freezed()
abstract class RelationshipMetaDataOut with _$RelationshipMetaDataOut {
  const factory RelationshipMetaDataOut({
    @JsonKey(name: 'is_already_following') required bool isAlreadyFollowing,
    @JsonKey(name: 'is_already_requested_to_follow')
    bool? isAlreadyRequestedToFollow,
  }) = _RelationshipMetaDataOut;

  factory RelationshipMetaDataOut.fromJson(Map<String, Object?> json) =>
      _$RelationshipMetaDataOutFromJson(json);
}
