import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/draft/providers/giglist_draft_controller.dart';
import 'package:mobile_gigger_app/features/draft/providers/sup_draft_controller.dart';
import 'package:mobile_gigger_app/features/draft/providers/video_draft_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_giglist_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_layout_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/giglist_controller.dart';
import 'package:mobile_gigger_app/models/call_to_action.dart';
import 'package:mobile_gigger_app/models/draft_model.dart';
import 'package:mobile_gigger_app/models/gig_list_media.dart';
import 'package:mobile_gigger_app/models/hash_tag.dart';
import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';

abstract class FormUtil {
  Future<void> saveDraft({
    required String uuid,
    required String title,
    required String place,
    required WidgetRef ref,
    required String caption,
    required String musicTitle,
    required String profileUuid,
    required int? wageRequested,
    required PostFormState state,
    required List<HashTag> hashtags,
  });

  Future<void> deleteDraft({
    required String uuid,
    required WidgetRef ref,
  });

  Future<void> api({
    num? lat,
    num? long,
    String? uuid,
    String? location,
    required String title,
    required bool isDraft,
    required String caption,
    required bool isPrivate,
    required String videoUrl,
    required bool isPerformer,
    required String musicTitle,
    required int wageRequested,
    required bool isLookingFor,
    required String profileUuid,
    required String thumbnailUrl,
    required bool addCallToAction,
    required ProviderContainer ref,
    required bool isMembershipOnly,
    required List<HashTag> hashtags,
    required bool isOnlyForFollowers,
    required List<GigListMedia> medias,
    required CallToAction callToAction,
    required List<String> taggedProfiles,
    required SupCreatedFromEnum createFrom,
  });
}

class PostFormUtil extends FormUtil {
  @override
  Future<void> saveDraft({
    required String uuid,
    required String title,
    required String place,
    required WidgetRef ref,
    required String caption,
    required String musicTitle,
    required String profileUuid,
    required int? wageRequested,
    required PostFormState state,
    required List<HashTag> hashtags,
  }) async {
    await ref.read(videoDraftControllerProvider.notifier).save(
          PostDraftModel(
            uuid: uuid,
            isDraft: true,
            lat: state.lat,
            location: place,
            long: state.long,
            postTitle: title,
            caption: caption,
            hashtags: hashtags,
            musicTitle: musicTitle,
            profileUuid: profileUuid,
            createdAt: DateTime.now(),
            isPrivate: state.isPrivate,
            taggedProfiles: state.taggedProfiles,
            isMembershipOnly: state.isMembershipOnly,
            videoUrl: state.pickVideoFile?.path ?? '',
            isOnlyForFollowers: state.isOnlyForFollowers,
            thumbnailUrl: state.thumbnailImageFile?.path ?? '',
          ),
        );
  }

  @override
  Future<void> deleteDraft({
    required String uuid,
    required WidgetRef ref,
  }) async {
    await ref.read(videoDraftControllerProvider.notifier).delete(uuid);
  }

  @override
  Future<void> api({
    num? lat,
    num? long,
    String? uuid,
    String? location,
    required String title,
    required bool isDraft,
    required String caption,
    required bool isPrivate,
    required String videoUrl,
    required bool isPerformer,
    required String musicTitle,
    required int wageRequested,
    required bool isLookingFor,
    required String profileUuid,
    required String thumbnailUrl,
    required bool addCallToAction,
    required ProviderContainer ref,
    required bool isMembershipOnly,
    required List<HashTag> hashtags,
    required bool isOnlyForFollowers,
    required List<GigListMedia> medias,
    required CallToAction callToAction,
    required List<String> taggedProfiles,
    required SupCreatedFromEnum createFrom,
  }) async {
    if (uuid != null) {
      await ref.read(postFormControllerProvider.notifier).updatePost(
            lat: lat,
            long: long,
            title: title,
            postUuid: uuid,
            caption: caption,
            isDraft: isDraft,
            hashtags: hashtags,
            videoUrl: videoUrl,
            location: location,
            isPrivate: isPrivate,
            musicTitle: musicTitle,
            profileUuid: profileUuid,
            thumbnailUrl: thumbnailUrl,
            wageRequested: wageRequested,
            taggedProfiles: taggedProfiles,
            isMembershipOnly: isMembershipOnly,
            isOnlyForFollowers: isOnlyForFollowers,
          );
    } else {
      await ref.read(postFormControllerProvider.notifier).createPost(
            lat: lat,
            long: long,
            title: title,
            caption: caption,
            isDraft: isDraft,
            hashtags: hashtags,
            videoUrl: videoUrl,
            location: location,
            isPrivate: isPrivate,
            musicTitle: musicTitle,
            profileUuid: profileUuid,
            thumbnailUrl: thumbnailUrl,
            wageRequested: wageRequested,
            taggedProfiles: taggedProfiles,
            isMembershipOnly: isMembershipOnly,
            isOnlyForFollowers: isOnlyForFollowers,
          );
    }

    ref.read(fabLayoutControllerProvider(profileUuid).notifier).refresh();
    ref.read(fabControllerProvider(profileUuid).notifier).refresh();
  }
}

class SupFormUtil implements FormUtil {
  @override
  Future<void> saveDraft({
    required String uuid,
    required String title,
    required String place,
    required WidgetRef ref,
    required String caption,
    required String musicTitle,
    required String profileUuid,
    required int? wageRequested,
    required PostFormState state,
    required List<HashTag> hashtags,
  }) async {
    await ref.read(supDraftControllerProvider.notifier).save(
          SupDraftModel(
            uuid: uuid,
            lat: state.lat,
            location: place,
            long: state.long,
            caption: caption,
            hashtags: hashtags,
            profileUuid: profileUuid,
            createdAt: DateTime.now(),
            createFrom: state.createdFrom,
            taggedProfiles: state.taggedProfiles,
            isMembershipOnly: state.isMembershipOnly,
            videoUrl: state.pickVideoFile?.path ?? '',
            isOnlyForFollowers: state.isOnlyForFollowers,
            thumbnailUrl: state.thumbnailImageFile?.path ?? '',
          ),
        );
  }

  @override
  Future<void> deleteDraft({
    required String uuid,
    required WidgetRef ref,
  }) async {
    await ref.read(supDraftControllerProvider.notifier).delete(uuid);
  }

  @override
  Future<void> api({
    num? lat,
    num? long,
    String? uuid,
    String? location,
    required String title,
    required bool isDraft,
    required String caption,
    required bool isPrivate,
    required String videoUrl,
    required bool isPerformer,
    required String musicTitle,
    required int wageRequested,
    required bool isLookingFor,
    required String profileUuid,
    required String thumbnailUrl,
    required bool addCallToAction,
    required ProviderContainer ref,
    required bool isMembershipOnly,
    required List<HashTag> hashtags,
    required bool isOnlyForFollowers,
    required List<GigListMedia> medias,
    required CallToAction callToAction,
    required List<String> taggedProfiles,
    required SupCreatedFromEnum createFrom,
  }) async {
    await ref.read(postFormControllerProvider.notifier).createSup(
          lat: lat,
          long: long,
          caption: caption,
          hashtags: hashtags,
          videoUrl: videoUrl,
          location: location,
          createFrom: createFrom,
          profileUuid: profileUuid,
          thumbnailUrl: thumbnailUrl,
          taggedProfiles: taggedProfiles,
          isMembershipOnly: isMembershipOnly,
          isOnlyForFollowers: isOnlyForFollowers,
        );
  }
}

class GiglistFormUtil implements FormUtil {
  @override
  Future<void> saveDraft({
    required String uuid,
    required String title,
    required String place,
    required WidgetRef ref,
    required String caption,
    required String musicTitle,
    required String profileUuid,
    required int? wageRequested,
    required PostFormState state,
    required List<HashTag> hashtags,
  }) async {
    await ref.read(giglistDraftControllerProvider.notifier).save(
          GigListDraftModel(
            uuid: uuid,
            title: title,
            lat: state.lat,
            location: place,
            long: state.long,
            hashtags: hashtags,
            description: caption,
            profileUuid: profileUuid,
            createdAt: DateTime.now(),
            wageRequested: wageRequested,
            isPerformer: state.isPerformer,
            gigListMedia: state.gigListMedia,
            isLookingFor: state.isLookingFor,
            callToAction: state.callToAction,
            addCallToAction: state.addCallToAction,
            thumbnailUrl: state.thumbnailImageFile?.path ?? '',
          ),
        );
  }

  @override
  Future<void> deleteDraft({
    required String uuid,
    required WidgetRef ref,
  }) async {
    await ref.read(giglistDraftControllerProvider.notifier).delete(uuid);
  }

  @override
  Future<void> api({
    num? lat,
    num? long,
    String? uuid,
    String? location,
    required String title,
    required bool isDraft,
    required String caption,
    required bool isPrivate,
    required String videoUrl,
    required bool isPerformer,
    required String musicTitle,
    required int wageRequested,
    required bool isLookingFor,
    required String profileUuid,
    required String thumbnailUrl,
    required bool addCallToAction,
    required ProviderContainer ref,
    required bool isMembershipOnly,
    required List<HashTag> hashtags,
    required bool isOnlyForFollowers,
    required List<GigListMedia> medias,
    required CallToAction callToAction,
    required List<String> taggedProfiles,
    required SupCreatedFromEnum createFrom,
  }) async {
    if (uuid != null) {
      await ref.read(postFormControllerProvider.notifier).updateGiglist(
            lat: lat,
            long: long,
            uuid: uuid,
            title: title,
            medias: medias,
            caption: caption,
            hashtags: hashtags,
            location: location,
            profileUuid: profileUuid,
            isPerformer: isPerformer,
            thumbnailUrl: thumbnailUrl,
            isLookingFor: isLookingFor,
            callToAction: callToAction,
            wageRequested: wageRequested,
            addCallToAction: addCallToAction,
          );
    } else {
      await ref.read(postFormControllerProvider.notifier).createGiglist(
            lat: lat,
            long: long,
            title: title,
            medias: medias,
            caption: caption,
            hashtags: hashtags,
            location: location,
            profileUuid: profileUuid,
            isPerformer: isPerformer,
            thumbnailUrl: thumbnailUrl,
            isLookingFor: isLookingFor,
            callToAction: callToAction,
            wageRequested: wageRequested,
            addCallToAction: addCallToAction,
          );
    }

    ref.read(recommendedGiglistControllerProvider.notifier).refresh();
    ref.read(giglistControllerProvider.notifier).refresh();
  }
}
