import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_gigger_app/models/call_to_action.dart';
import 'package:mobile_gigger_app/models/gig_list_media.dart';
import 'package:mobile_gigger_app/models/hash_tag.dart';
import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';

part 'draft_model.freezed.dart';
part 'draft_model.g.dart';

@freezed
class PostDraftModel with _$PostDraftModel {
  factory PostDraftModel({
    @JsonKey(name: 'post_title') required String postTitle,
    required String caption,
    @JsonKey(name: 'music_title') required String musicTitle,
    @JsonKey(name: 'profile_uuid') required String profileUuid,
    @JsonKey(name: 'is_private') required bool isPrivate,
    @JsonKey(name: 'is_membership_only') required bool isMembershipOnly,
    @JsonKey(name: 'is_only_for_followers') required bool isOnlyForFollowers,
    @JsonKey(name: 'video_url') required String videoUrl,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
    required List<HashTag> hashtags,
    @JsonKey(name: 'tagged_profiles') required List<String> taggedProfiles,
    required String location,
    @JsonKey(name: 'is_draft') @Default(false) bool isDraft,
    num? lat,
    num? long,
    required String uuid,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _PostDraftModel;

  factory PostDraftModel.fromJson(Map<String, dynamic> json) =>
      _$PostDraftModelFromJson(json);
}

@Freezed()
class SupDraftModel with _$SupDraftModel {
  const factory SupDraftModel({
    required String caption,
    @JsonKey(name: 'video_url') required String videoUrl,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
    required List<HashTag> hashtags,
    @JsonKey(name: 'is_membership_only') required bool isMembershipOnly,
    @JsonKey(name: 'is_only_for_followers') required bool isOnlyForFollowers,
    @JsonKey(name: 'tagged_profiles') required List<String> taggedProfiles,
    required String location,
    @JsonKey(name: 'profile_uuid') required String profileUuid,
    @JsonKey(name: 'create_from') required SupCreatedFromEnum createFrom,
    num? lat,
    num? long,
    required String uuid,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _SupDraftModel;

  factory SupDraftModel.fromJson(Map<String, Object?> json) =>
      _$SupDraftModelFromJson(json);
}

@Freezed()
class GigListDraftModel with _$GigListDraftModel {
  const factory GigListDraftModel({
    @JsonKey(name: 'profile_uuid') required String profileUuid,
    required String title,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,

    /// Gig list media, key is int and  position of media

    @JsonKey(name: 'gig_list_media')
    required Map<String, GigListMedia> gigListMedia,
    required String description,
    required String location,
    required List<HashTag> hashtags,
    @JsonKey(name: 'wage_requested') required num? wageRequested,
    @JsonKey(name: 'is_looking_for') required bool isLookingFor,
    @JsonKey(name: 'is_performer') required bool isPerformer,
    @JsonKey(name: 'add_call_to_action') required bool addCallToAction,
    @JsonKey(name: 'call_to_action') required CallToAction callToAction,
    num? lat,
    num? long,
    required String uuid,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _GigListDraftModel;

  factory GigListDraftModel.fromJson(Map<String, Object?> json) =>
      _$GigListDraftModelFromJson(json);
}
