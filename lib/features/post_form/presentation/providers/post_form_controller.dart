import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_giglist_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/selector_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/sup_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/giglist_controller.dart';
import 'package:mobile_gigger_app/models/call_to_action.dart';
import 'package:mobile_gigger_app/models/draft_model.dart';
import 'package:mobile_gigger_app/models/gig_list_media.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:mobile_gigger_app/models/gig_list_update.dart';
import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile_gigger_app/core/providers/dio_provider.dart';
import 'package:mobile_gigger_app/features/post_form/data/gig_lists/gig_lists_provider.dart';
import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/data/sup/sup_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/gig_lists/gig_lists_use_case.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/features/post_form/domain/sup/sup_use_case.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_controller.dart';
import 'package:mobile_gigger_app/models/gig_list_create.dart';
import 'package:mobile_gigger_app/models/hash_tag.dart';
import 'package:mobile_gigger_app/models/post_create.dart';
import 'package:mobile_gigger_app/models/post_update.dart';
import 'package:mobile_gigger_app/models/sup_create.dart';
import 'package:mobile_gigger_app/models/validation_error.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' hide LatLng;

part 'post_form_controller.freezed.dart';
part 'post_form_controller.g.dart';

enum ContentType {
  post('Post'),
  sup('S\'Up'),
  giglist('Giglist');

  final String value;

  const ContentType(this.value);

  bool get isPost => this == post;
  bool get isSUp => this == sup;
  bool get isGiglist => this == giglist;
}

@Riverpod(keepAlive: true)
class PostFormController extends _$PostFormController {
  @override
  PostFormState build() => PostFormState.init();

  void clear() {
    state = PostFormState.init();
  }

  Future<void> createPost({
    required String title,
    required String caption,
    required String videoUrl,
    required String musicTitle,
    required int wageRequested,
    required String profileUuid,
    required String thumbnailUrl,
    required List<HashTag> hashtags,
    required List<String> taggedProfiles,
    required String? location,
    required bool isMembershipOnly,
    required bool isOnlyForFollowers,
    required bool isPrivate,
    required bool isDraft,
    required num? lat,
    required num? long,
  }) async {
    var model = PostCreate(
      lat: lat ?? 0,
      long: long ?? 0,
      postTitle: title,
      caption: caption,
      isDraft: isDraft,
      videoUrl: videoUrl,
      hashtags: hashtags,
      isPrivate: isPrivate,
      musicTitle: musicTitle,
      profileUuid: profileUuid,
      location: location ?? '',
      thumbnailUrl: thumbnailUrl,
      taggedProfiles: taggedProfiles,
      isMembershipOnly: isMembershipOnly,
      isOnlyForFollowers: isOnlyForFollowers,
    );

    await postApiV1PostsUseCase(body: model, repo: ref.read(postsRepoProvider));

    ref.read(recommendedVideoControllerProvider.notifier).refresh();
    ref.watch(fabControllerProvider(profileUuid).notifier).refresh();
  }

  Future<void> updatePost({
    required String title,
    required String postUuid,
    required String caption,
    required String videoUrl,
    required String musicTitle,
    required int wageRequested,
    required String profileUuid,
    required String thumbnailUrl,
    required List<HashTag> hashtags,
    required List<String> taggedProfiles,
    required String? location,
    required bool isPrivate,
    required bool isDraft,
    required bool isMembershipOnly,
    required bool isOnlyForFollowers,
    required num? lat,
    required num? long,
  }) async {
    var model = PostUpdate(
      lat: lat ?? 0,
      long: long ?? 0,
      uuid: postUuid,
      postTitle: title,
      caption: caption,
      isDraft: isDraft,
      videoUrl: videoUrl,
      hashtags: hashtags,
      isPrivate: isPrivate,
      musicTitle: musicTitle,
      profileUuid: profileUuid,
      location: location ?? '',
      thumbnailUrl: thumbnailUrl,
      taggedProfiles: taggedProfiles,
      isMembershipOnly: isMembershipOnly,
      isOnlyForFollowers: isOnlyForFollowers,
    );

    var r = await patchApiV1PostsPostUuidUseCase(
      body: model,
      postUuid: postUuid,
      repo: ref.read(postsRepoProvider),
    );

    ref.read(recommendedVideoControllerProvider.notifier).updateData(r);
    ref.watch(fabControllerProvider(profileUuid).notifier).refresh();
  }

  Future<void> createSup({
    required String caption,
    required String videoUrl,
    required String profileUuid,
    required String thumbnailUrl,
    required List<HashTag> hashtags,
    required List<String> taggedProfiles,
    required String? location,
    required bool isMembershipOnly,
    required bool isOnlyForFollowers,
    required SupCreatedFromEnum createFrom,
    required num? lat,
    required num? long,
  }) async {
    try {
      var model = SupCreate(
        lat: lat ?? 0,
        long: long ?? 0,
        caption: caption,
        hashtags: hashtags,
        videoUrl: videoUrl,
        createFrom: createFrom,
        profileUuid: profileUuid,
        location: location ?? '',
        thumbnailUrl: thumbnailUrl,
        taggedProfiles: taggedProfiles,
        isMembershipOnly: isMembershipOnly,
        isOnlyForFollowers: isOnlyForFollowers,
      );
      await postApiV1SupUseCase(repo: ref.read(supRepoProvider), body: model);

      ref.read(supControllerProvider(createFrom).notifier).refresh();
    } on HttpValidationException catch (e) {
      var error = e.error as List<ValidationError>?;
      state = state.copyWith(formErrorOb: error);

      if (e.message != null) {
        Toast.error(e.message!);
      }
    }
  }

  Future<void> createGiglist({
    required String title,
    required String caption,
    required int wageRequested,
    required String profileUuid,
    required String thumbnailUrl,
    required List<HashTag> hashtags,
    required List<GigListMedia> medias,
    required String? location,
    required bool isPerformer,
    required bool isLookingFor,
    required bool addCallToAction,
    required CallToAction callToAction,
    required num? lat,
    required num? long,
  }) async {
    var model = GigListCreate(
      lat: lat ?? 0,
      long: long ?? 0,
      title: title,
      hashtags: hashtags,
      description: caption,
      profileUuid: profileUuid,
      location: location ?? '',
      isPerformer: isPerformer,
      thumbnailUrl: thumbnailUrl,
      isLookingFor: isLookingFor,
      callToAction: callToAction,
      wageRequested: wageRequested,
      addCallToAction: addCallToAction,
      gigListMedia: medias.asMap().map((key, value) => MapEntry('$key', value)),
    );

    var r = await postApiV1GigListUseCase(
      body: model,
      repo: ref.read(gigListsRepoProvider),
    );

    ref.read(giglistControllerProvider.notifier).add(r);
    ref.read(recommendedGiglistControllerProvider.notifier).add(r);
  }

  Future<void> updateGiglist({
    required String uuid,
    required String title,
    required String caption,
    required String? location,
    required bool isPerformer,
    required int wageRequested,
    required bool isLookingFor,
    required String profileUuid,
    required String thumbnailUrl,
    required bool addCallToAction,
    required List<HashTag> hashtags,
    required List<GigListMedia> medias,
    required CallToAction callToAction,
    required num? lat,
    required num? long,
  }) async {
    var model = GigListUpdate(
      lat: lat ?? 0,
      long: long ?? 0,
      uuid: uuid,
      title: title,
      hashtags: hashtags,
      description: caption,
      location: location ?? '',
      isPerformer: isPerformer,
      thumbnailUrl: thumbnailUrl,
      isLookingFor: isLookingFor,
      callToAction: callToAction,
      wageRequested: wageRequested,
      addCallToAction: addCallToAction,
      gigListMedia: medias.asMap().map((key, value) => MapEntry('$key', value)),
    );

    var r = await patchApiV1GigListGigListUuidUseCase(
      repo: ref.read(gigListsRepoProvider),
      body: model,
      gigListUuid: uuid,
    );

    ref.read(giglistControllerProvider.notifier).updateData(r);
    ref.read(recommendedGiglistControllerProvider.notifier).updateData(r);
  }

  void type(ContentType value) {
    state = PostFormState.init().copyWith(type: value);
  }

  void createdFrom(SupCreatedFromEnum createdFrom) {
    state = state.copyWith(createdFrom: createdFrom);
  }

  void isOnlyForFollowers(bool v) {
    state = state.copyWith(isOnlyForFollowers: v);
  }

  void isLookingFor(bool v) {
    state = state.copyWith(isLookingFor: v);
  }

  void isPerformer(bool v) {
    state = state.copyWith(isPerformer: v);
  }

  void isPrivate(bool v) {
    state = state.copyWith(isPrivate: v);
  }

  void addCallToAction(
    String name,
    String url,
    String title,
    String desc,
    int groupValue,
  ) {
    CallToAction callToAction;

    if (groupValue == 0) {
      callToAction = CallToAction(name: 'None', value: '');
    } else if (groupValue == 7) {
      callToAction = CallToAction(name: title, value: desc);
    } else {
      callToAction = CallToAction(name: name, value: url);
    }

    state = state.copyWith(
      addCallToAction: groupValue != 0,
      callToAction: callToAction,
    );
  }

  void isMembershipOnly(bool v) {
    state = state.copyWith(isMembershipOnly: v);
  }

  void videoData({
    required File thumbnailImg,
    required File video,
    required bool isHori,
  }) {
    state = state.copyWith(
      isHori: isHori,
      videoUrl: null,
      thumbnailImageUrl: null,
      thumbnailImageFile: thumbnailImg,
      pickVideoFile: video,
    );
  }

  void videoUrl({
    required String videoUrl,
    required String thumbnailImageUrl,
  }) {
    state = state.copyWith(
      videoUrl: videoUrl,
      thumbnailImageUrl: thumbnailImageUrl,
    );
  }

  void hashTag(HashTag hashtag, {bool isOnly = false}) {
    if (isOnly) {
      state = state.copyWith(hashtags: [hashtag]);
      return;
    }

    if (state.hashtags
        .any((e) => e.uuid == hashtag.uuid || e.name == hashtag.name)) {
      return;
    }

    if (isOnly) {
      state = state.copyWith(hashtags: [hashtag]);
    } else {
      state = state.copyWith(hashtags: [...state.hashtags, hashtag]);
    }
  }

  void setSupDataFromDraft(SupDraftModel data) {
    state = state.copyWith(
      isDraft: true,
      lat: data.lat,
      long: data.long,
      createdFrom: data.createFrom,
      pickVideoFile: File(data.videoUrl),
      taggedProfiles: data.taggedProfiles,
      isMembershipOnly: data.isMembershipOnly,
      isOnlyForFollowers: data.isOnlyForFollowers,
      thumbnailImageFile: File(data.thumbnailUrl),
    );
  }

  void taggedProfile(String uuid) {
    if (state.taggedProfiles.any((e) => e == uuid)) {
      return;
    }

    state = state.copyWith(taggedProfiles: [...state.taggedProfiles, uuid]);
  }

  void hashTags(List<HashTag> hashtags) {
    state = state.copyWith(hashtags: hashtags);
  }

  Future<void> deletePost(String uuid, String profileUuid) async {
    var repo = ref.read(postsRepoProvider);
    var r = await deleteApiV1PostsPostUuidUseCase(postUuid: uuid, repo: repo);
    Toast.success(r.message);

    ref.read(fabControllerProvider(profileUuid).notifier).refresh();
  }

  Future<void> deleteGiglist(String uuid) async {
    var repo = ref.read(gigListsRepoProvider);
    var r = await deleteApiV1GigListGigListUuidUseCase(
      repo: repo,
      gigListUuid: uuid,
    );
    Toast.success(r.message);

    ref.read(recommendedGiglistControllerProvider.notifier).refresh();
    ref.read(giglistControllerProvider.notifier).refresh();
  }

  Future<void> deleteSUp(String uuid) async {
    var repo = ref.read(supRepoProvider);
    var r = await deleteApiV1SupSupUuidUseCase(
      repo: repo,
      supUuid: uuid,
    );
    Toast.success(r.message);

    var createFrom = ref.watch(selectorControllerProvider);

    ref.read(supControllerProvider(createFrom).notifier).refresh();
  }

  void gigListMedia(String url, [bool isVideo = false]) {
    var medias = state.gigListMedia.values.toList();

    if (!medias.any((e) => e.mediaUrl == url)) {
      medias.add(GigListMedia(mediaUrl: url, isVideo: isVideo));
    }

    state = state.copyWith(
      gigListMedia: medias.asMap().map(
            (key, value) => MapEntry('$key', value),
          ),
    );
  }

  void gigListAssets(List<AssetEntity> assets) {
    state = state.copyWith(gigListAssets: assets);
  }

  void thumbnailImageFile(File thumbnailFile) {
    state = state.copyWith(thumbnailImageFile: thumbnailFile);
  }

  void removeMedia(int i) {
    var medias = state.gigListMedia.values.toList();
    medias.removeAt(i);

    state = state.copyWith(
      gigListMedia: medias.asMap().map(
            (key, value) => MapEntry('$key', value),
          ),
    );
  }

  void setGiglistData(GigListOut data) {
    state = state.copyWith(
      hashtags: data.hashtags,
      isPerformer: data.isPerformer,
      isLookingFor: data.isLookingFor,
      gigListMedia: data.gigListMedia,
      callToAction: data.callToAction,
      addCallToAction: data.addCallToAction,
    );

    state = state.copyWith(thumbnailImageUrl: data.thumbnailUrl);
  }

  void setGiglistDataFromDraft(GigListDraftModel data) {
    state = state.copyWith(
      hashtags: data.hashtags,
      isPerformer: data.isPerformer,
      isLookingFor: data.isLookingFor,
      gigListMedia: data.gigListMedia,
      callToAction: data.callToAction,
      addCallToAction: data.addCallToAction,
    );

    state = state.copyWith(
      isDraft: true,
      thumbnailImageFile:
          data.thumbnailUrl.isEmpty ? null : File(data.thumbnailUrl),
    );
  }

  void copy({
    num? lat,
    num? long,
    String? videoUrl,
    File? pickVideoFile,
    required bool isHori,
    required bool isDraft,
    required bool isPrivate,
    File? thumbnailImageFile,
    required ContentType type,
    String? thumbnailImageUrl,
    required bool isPerformer,
    required bool isLookingFor,
    required bool addCallToAction,
    required bool isMembershipOnly,
    required List<HashTag> hashtags,
    required bool isOnlyForFollowers,
    List<ValidationError>? formErrorOb,
    required List<String> taggedProfiles,
    required CallToAction callToAction,
    required SupCreatedFromEnum createdFrom,
    required List<AssetEntity> gigListAssets,
    required Map<String, GigListMedia> gigListMedia,
  }) {
    state = state.copyWith(
      lat: lat,
      type: type,
      long: long,
      isHori: isHori,
      isDraft: isDraft,
      videoUrl: videoUrl,
      hashtags: hashtags,
      isPrivate: isPrivate,
      isPerformer: isPerformer,
      formErrorOb: formErrorOb,
      createdFrom: createdFrom,
      isLookingFor: isLookingFor,
      gigListMedia: gigListMedia,
      callToAction: callToAction,
      pickVideoFile: pickVideoFile,
      gigListAssets: gigListAssets,
      taggedProfiles: taggedProfiles,
      addCallToAction: addCallToAction,
      isMembershipOnly: isMembershipOnly,
      thumbnailImageUrl: thumbnailImageUrl,
      isOnlyForFollowers: isOnlyForFollowers,
      thumbnailImageFile: thumbnailImageFile,
    );
    ref.notifyListeners();
  }

  void isDraft(bool value) {
    state = state.copyWith(isDraft: value);
    ref.notifyListeners();
  }

  void latLng(LatLng latLng) {
    state = state.copyWith(lat: latLng.latitude, long: latLng.longitude);
    ref.notifyListeners();
  }

  void latLngFrom(num? lat, num? long) {
    state = state.copyWith(lat: lat, long: long);
    ref.notifyListeners();
  }
}

@Freezed(fromJson: false, toJson: false)
class PostFormState with _$PostFormState {
  factory PostFormState({
    required ContentType type,
    required bool isPrivate,
    required bool isDraft,
    required bool isMembershipOnly,
    required bool isOnlyForFollowers,
    num? lat,
    num? long,
    String? thumbnailImageUrl,
    File? thumbnailImageFile,
    String? videoUrl,
    File? pickVideoFile,
    required bool isHori,
    required bool isLookingFor,
    required bool isPerformer,
    required bool addCallToAction,
    required List<HashTag> hashtags,
    required List<String> taggedProfiles,
    List<ValidationError>? formErrorOb,
    required Map<String, GigListMedia> gigListMedia,
    required CallToAction callToAction,
    required SupCreatedFromEnum createdFrom,
    required List<AssetEntity> gigListAssets,
  }) = _PostFormState;

  factory PostFormState.init() {
    return PostFormState(
      hashtags: [],
      isHori: false,
      isDraft: false,
      formErrorOb: [],
      isPrivate: false,
      gigListMedia: {},
      isPerformer: true,
      gigListAssets: [],
      isLookingFor: true,
      taggedProfiles: [],
      addCallToAction: false,
      type: ContentType.post,
      isMembershipOnly: false,
      isOnlyForFollowers: false,
      createdFrom: SupCreatedFromEnum.none,
      callToAction: CallToAction(name: 'None', value: ''),
    );
  }
}
