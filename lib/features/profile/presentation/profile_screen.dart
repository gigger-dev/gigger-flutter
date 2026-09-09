import 'dart:io';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/aws_helper.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/crop_gif.dart';
import 'package:mobile_gigger_app/core/utils/profile_out_2_update.dart';
import 'package:mobile_gigger_app/core/utils/save_temp_file.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/home/providers/self_event_controller.dart';
import 'package:mobile_gigger_app/features/main/main_screen.dart';
import 'package:mobile_gigger_app/features/main/providers/main_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/event_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_draft_layout_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_layout_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/get_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/giglist_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/metadata_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_edit_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_fab_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_offset_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/accordian_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/bio_textbox.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/confirm_menu_bar.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/confirm_dialog.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/count_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/cover_image.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/event_content_tile.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/fab_six_video.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/fab_three_video.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/giglist_item.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/motto_edit_textbox.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/private_badge.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/profile_bio_sheet.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/profile_edit_sheet.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/profile_scrollbar.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/status_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/topbar_menu.dart';
import 'package:mobile_gigger_app/models/achievement_out.dart';
import 'package:mobile_gigger_app/models/availability_out.dart';
import 'package:mobile_gigger_app/models/contact_out.dart';
import 'package:mobile_gigger_app/models/education_out.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/models/experiences_out.dart';
import 'package:mobile_gigger_app/models/file_type.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';
import 'package:mobile_gigger_app/models/location_in.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/models/social_link_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/show_image_viewer.dart';
import 'package:mobile_gigger_app/widgets/top_gradient.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key, this.uuid, this.isInitialEdit = false});

  final String? uuid;
  final bool isInitialEdit;

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final scrollController = ScrollController();
  final coverImageController = CustomImageCropController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileOffsetControllerProvider.notifier).update(0);
      if (widget.isInitialEdit) {
        ref.read(profileEditControllerProvider.notifier).startEdit();
      } else {
        ref.read(profileEditControllerProvider.notifier).dismiss();
      }
    });

    scrollController.addListener(() {
      ref
          .read(profileOffsetControllerProvider.notifier)
          .update(scrollController.offset);
    });

    var uuid = ref.read(profileControllerProvider).valueOrNull?.uuid;

    if (uuid == null || widget.uuid == null) return;

    if (uuid != widget.uuid) {
      ref.read(metadataControllerProvider(widget.uuid!).notifier).view(uuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    var acc = ref.watch(profileControllerProvider).valueOrNull;

    ProfileOut? profile = getProfile();

    List<PostOut> fabs = List.from(getFabs(profile));

    if (profile == null) return Scaffold(body: CircularLoading());

    var metadata = ref
        .watch(metadataControllerProvider(profile.uuid))
        .whenData((v) => v)
        .valueOrNull;

    if (metadata == null) return Scaffold(body: CircularLoading());

    var isVisitor = profile.uuid != acc?.uuid;

    var cdnUrl = ref.watch(configProvider.select((v) => v.value?.cdnUrl));

    var location = LocationIn.fromJson(profile.location.toJson());

    var avatarMedia = '$cdnUrl/${profile.avatarMedia}';
    var coverMedia = '$cdnUrl/${profile.coverMedia}';

    var editState = ref.watch(profileEditControllerProvider);
    var offset = ref.watch(profileOffsetControllerProvider);

    var giglists = _getGiglists(profile.uuid);
    var events = _getEvents();

    var draftLayout = ref.watch(fabDraftLayoutControllerProvider(profile.uuid));
    var fabLayout =
        ref.watch(fabLayoutControllerProvider(profile.uuid)).valueOrNull ?? [];

    var layout = editState.isEditMode ? draftLayout : fabLayout;

    List<PostOut> sortedFabs = [
      for (int i = 0; i < layout.length; i++)
        if (fabs.indexWhere((e) => e.uuid == layout[i]) != -1)
          fabs[fabs.indexWhere((e) => e.uuid == layout[i])],
    ];

    sortedFabs.addAll(fabs.where((item) => !sortedFabs.contains(item)));

    var isPrivate = isVisitor &&
        profile.isPrivateProfile &&
        !(metadata.relationshipMetaData?.isAlreadyFollowing ?? false);

    return SafeArea(
      child: MainScreen(
        isHide: !isVisitor,
        child: Scaffold(
          body: RefreshIndicator(
            displacement: 60,
            onRefresh: () => onRefresh(profile.uuid),
            child: Stack(
              children: [
                CoverImage(
                  coverMedia: coverMedia,
                  coverFile: editState.coverFile,
                  cropController: coverImageController,
                  coverImageFile: editState.coverImageFile,
                ),
                ProfileScrollbar(
                  offset: offset,
                  controller: scrollController,
                  isCoverEdit: editState.isCoverEdit,
                  children: [
                    if (!editState.isCoverEdit)
                      GestureDetector(
                        onTap: () => showImageViewer(context, url: coverMedia),
                        child: Container(
                          height: 0.5.sh,
                          color: colorTransparent,
                        ),
                      ),
                    ProfileInfoWidget(
                      location: location,
                      isVisitor: isVisitor,
                      skills: profile.skills,
                      avatarMedia: avatarMedia,
                      onFollowTap: onFollowTap,
                      onUnFollowTap: onUnFollowTap,
                      isEditMode: editState.isEditMode,
                      username: profile.account.username,
                      isPrivateProfile: profile.isPrivateProfile,
                      isAlreadyRequestedToFollow: metadata.relationshipMetaData
                              ?.isAlreadyRequestedToFollow ??
                          false,
                      isAlreadyFollowing:
                          metadata.relationshipMetaData?.isAlreadyFollowing ??
                              false,
                    ),
                    if (isPrivate)
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: PrivateBadge(),
                      ),
                    if (!isPrivate)
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CountWidget(
                                  uuid: profile.uuid,
                                  profileUuid: acc!.uuid,
                                  isVisitor: isVisitor,
                                  likeCount: metadata.likeCount,
                                  viewCount: metadata.viewCount,
                                  followersCount: metadata.followersCount,
                                ),
                                SizedBox(height: 25.h),
                                StatusWidget(
                                  isEditMode: editState.isEditMode,
                                  availabilityStatus: editState.isEditMode &&
                                          editState.availabilityStatus != null
                                      ? editState.availabilityStatus!
                                      : profile.availabilityStatus,
                                  onEdit: () =>
                                      onStatusEdit(editState, profile),
                                  onTap: () => onStatusTap(
                                    profile.availabilityStatus,
                                    profile.availability,
                                  ),
                                ),
                                SizedBox(height: 35.h),
                                BioTextbox(
                                  key: ValueKey('edit_bio'),
                                  isEditMode: editState.isEditMode,
                                  onTap: () => onEditBio(profile),
                                  onReadBio: () => onReadBio(profile),
                                  bio: editState.isEditMode &&
                                          editState.bio.isNotEmpty
                                      ? editState.bio
                                      : profile.bio,
                                ),
                                SizedBox(height: 35.h),
                                if (!isVisitor)
                                  ListTile(
                                    dense: true,
                                    onTap: () =>
                                        ControlRoomRoute().push(context),
                                    contentPadding: EdgeInsets.zero,
                                    title: TextViewWidget(
                                      text: 'CONTROL ROOM',
                                      textSize: 16.sp,
                                    ),
                                    trailing: const Icon(
                                      CupertinoIcons.right_chevron,
                                      color: colorWhite,
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                TextViewWidget(
                                    text: 'FAB NINE', textSize: 16.sp),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                          FabSixVideo(
                            items: sortedFabs,
                            cdnUrl: cdnUrl ?? '',
                            uuid: profile.uuid,
                            isOwner: !isVisitor,
                            isEditMode: editState.isEditMode,
                            onDelete: (uuid) => onFabDelete(uuid, profile.uuid),
                          ),
                          MottoEditTextbox(
                            editLabel: 'Edit Motto',
                            text: profile.customPhrase,
                            isEdit: editState.isEditMode,
                            onChanged: onCustomPhraseChanged,
                          ),
                          FabThreeVideo(
                            items: sortedFabs,
                            cdnUrl: cdnUrl ?? '',
                            uuid: profile.uuid,
                            isOwner: !isVisitor,
                            isEditMode: editState.isEditMode,
                            onDelete: (uuid) => onFabDelete(uuid, profile.uuid),
                          ),
                          if (events.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: AccordionWidget(
                                title: 'UPCOMING EVENTS',
                                content: events.map((e) {
                                  return EventContentTile(
                                    e,
                                    cdnUrl,
                                    items: events,
                                    index: events.indexOf(e),
                                  );
                                }).toList(),
                              ),
                            ),
                          if (giglists.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: AccordionWidget(
                                title: 'GIGLIST',
                                content: giglists.map((e) {
                                  return GiglistItem(
                                    e,
                                    cdnUrl,
                                    uuid: widget.uuid,
                                    isVisitor: isVisitor,
                                    index: giglists.indexOf(e),
                                  );
                                }).toList(),
                              ),
                            ),
                          const SizedBox(height: 40),
                          MottoEditTextbox(
                            editLabel: 'Edit Closing Message',
                            text: profile.closingMessage,
                            isEdit: editState.isEditMode,
                            onChanged: onClosingMessageChanged,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                  ],
                ),
                TopGradient(height: 100),
                ConfirmMenuBar(
                  onCancel: showConfirmDialog,
                  isEditMode: editState.isEditMode,
                  isCoverEdit: editState.isCoverEdit,
                  onSave: () async {
                    if (editState.isCoverEdit) {
                      await onCoverUpload(
                        editState.coverFileName!,
                        profile,
                        editState.coverFile!,
                        editState.coverFileSize!,
                      );
                      return;
                    }
                    onSave(profile);
                  },
                ),
                TopbarMenu(
                  profile: profile,
                  location: location,
                  isOwner: !isVisitor,
                  avatarMedia: avatarMedia,
                  isEditMode: editState.isEditMode,
                  isCoverEdit: editState.isCoverEdit,
                  onProfileChanged: (file, name) async {
                    await onProfileUpload(file, name, profile);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onProfileUpload(
    MemoryImage image,
    String name,
    ProfileOut profile,
  ) async {
    try {
      DialogHelper.showOverlay(context);

      var file = await saveTempFile(bytes: image.bytes, name: name);

      // var r = await postApiV1FileUploadUseCase(
      //   fileType: FileType.profile,
      //   file: file,
      //   repo: ref.read(fileUploadRepoProvider),
      // );

      // var avatarMedia = r.imagePath;

      var avatarMedia = await AwsHelper.upload(
        path: file.path,
        fileType: FileType.profile,
        profileUuid: profile.uuid,
      );
      if (avatarMedia == null) return;

      var model = profileOut2Update(profile.copyWith(avatarMedia: avatarMedia));

      await ref.read(profileControllerProvider.notifier).updateProfile(model);

      if (!mounted) return;

      DialogHelper.hideLoading(context);
    } catch (e) {
      Toast.error(e.toString());
      DialogHelper.hideLoading(context);
    }
  }

  Future<void> onStatusEdit(ProfileEditState edit, ProfileOut profile) async {
    var data = await AvailabilityRoute(
      viewOnly: false,
      status: edit.availabilityStatus ?? profile.availabilityStatus,
      $extra: edit.availability ?? profile.availability,
    ).push<List>(context);

    if (data == null) return;

    ref.read(profileEditControllerProvider.notifier).availability(
          status: data[0],
          availability: data[1],
        );
  }

  void onReadBio(ProfileOut profile) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(top: 0.2.sh),
        child: ProfileBioSheet(profile: profile),
      ),
    );
  }

  Future<void> onEditBio(ProfileOut profile) async {
    var data = await showModalBottomSheet<List>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(top: 0.2.sh),
        child: EditBioSheet(profile: profile),
      ),
    );

    if (data == null) return;

    var bio = data[0] as String;
    var contactMe = data[1] as Map<String, TextEditingController>;
    var experiences = data[2] as List<ExperiencesOut>;
    var studies = data[3] as List<EducationOut>;
    var socialLinks = data[4] as List<SocialLinkOut>;
    var services = data[5] as List<String>;
    var achievements = data[6] as List<AchievementOut>;
    var interests = data[7] as List<InterestOut>;

    var contacts = contactMe.keys
        .map((e) => ContactOut(value: contactMe[e]!.text.trim(), type: e))
        .toList();

    ref.read(profileEditControllerProvider.notifier).setBioData(
          bio: bio,
          contacts: contacts,
          services: services,
          educations: studies,
          interests: interests,
          experiences: experiences,
          socialLinks: socialLinks,
          achievements: achievements,
        );
  }

  Future<void> showConfirmDialog() async {
    var result = await SheetUtils.showSimpleSheet(
      context: context,
      child: ConfirmDialog(),
    );

    if (result != true) return;

    ref.read(profileEditControllerProvider.notifier).dismiss();
  }

  Future<void> onCoverUpload(
    String coverFileName,
    ProfileOut profile,
    File entity,
    Size size,
  ) async {
    try {
      DialogHelper.showOverlay(context);

      String coverMedia;
      File? file;

      if (coverFileName.endsWith('.gif')) {
        var cropImageData = coverImageController.cropImageData;
        if (cropImageData == null) return;

        file = await cropGifWithFFmpeg(
          entity,
          cropImageData,
          coverFileName,
          size,
        );
      } else {
        var coverImageFinalFile = await coverImageController.onCropImage();
        if (coverImageFinalFile == null) {
          if (!mounted) return;
          return DialogHelper.hideLoading(context);
        }

        file = await saveTempFile(
          bytes: coverImageFinalFile.bytes,
          name: coverFileName,
        );
      }

      // var r = await postApiV1FileUploadUseCase(
      //   file: file,
      //   fileType: FileType.cover,
      //   repo: ref.read(fileUploadRepoProvider),
      // );

      if (file == null) return;

      var r = await AwsHelper.upload(
        path: file.path,
        fileType: FileType.cover,
        profileUuid: profile.uuid,
      );
      if (r == null) return;

      coverMedia = r;

      var model = profileOut2Update(profile.copyWith(coverMedia: coverMedia));

      await ref.read(profileControllerProvider.notifier).updateProfile(model);

      ref.read(profileEditControllerProvider.notifier).dismiss();

      if (!mounted) return;
      return DialogHelper.hideLoading(context);
    } catch (e) {
      Toast.error(e.toString());
      return DialogHelper.hideLoading(context);
    }
  }

  Future<void> onSave(ProfileOut profile) async {
    try {
      DialogHelper.showOverlay(context);

      var editState = ref.read(profileEditControllerProvider);

      var location = profile.location;

      var model = profileOut2Update(profile.copyWith(
        location: location,
        bio: editState.bio,
        contacts: editState.contacts,
        interests: editState.interests,
        educations: editState.educations,
        experiences: editState.experiences,
        socialLinks: editState.socialLinks,
        achievements: editState.achievements,
        customPhrase: editState.customPhrase ?? profile.customPhrase,
        availability: editState.availability ?? profile.availability,
        closingMessage: editState.closingMessage ?? profile.closingMessage,
        availabilityStatus:
            editState.availabilityStatus ?? profile.availabilityStatus,
      ));

      model = model.copyWith(services: editState.services);

      await ref.read(profileControllerProvider.notifier).updateProfile(model);
      await ref
          .read(fabDraftLayoutControllerProvider(profile.uuid).notifier)
          .save();

      ref.read(profileEditControllerProvider.notifier).dismiss();

      if (!mounted) return;
      return DialogHelper.hideLoading(context);
    } catch (e) {
      Toast.error(e.toString());

      return DialogHelper.hideLoading(context);
    }
  }

  void onBack(ProfileOut profile) {
    if (widget.uuid == null) {
      ref.read(mainControllerProvider.notifier).bottom(0);
      ref.read(profileEditControllerProvider.notifier).dismiss();
      ref.read(fabDraftLayoutControllerProvider(profile.uuid).notifier).reset();
    }
  }

  void onCustomPhraseChanged(String value) {
    ref.read(profileEditControllerProvider.notifier).customPhrase(value);
  }

  void onClosingMessageChanged(String value) {
    ref.read(profileEditControllerProvider.notifier).closingMessage(value);
  }

  ProfileOut? getProfile() {
    if (widget.uuid != null) {
      return ref
          .watch(getProfileControllerProvider(widget.uuid!))
          .whenData((v) => v)
          .valueOrNull;
    }

    return ref.watch(profileControllerProvider).valueOrNull;
  }

  List<PostOut> getFabs(ProfileOut? profile) {
    if (profile == null) return [];

    if (widget.uuid != null) {
      var items = ref
          .watch(profileFabControllerProvider(widget.uuid!))
          .whenData((v) => v)
          .value;

      return items ?? [];
    }

    var items = ref
        .watch(fabControllerProvider(profile.uuid))
        .whenData((v) => v)
        .value
        ?.items;

    return items ?? [];
  }

  Future<void> onFabDelete(String uuid, String profileUuid) async {
    DialogHelper.showOverlay(context);

    await ref
        .read(postFormControllerProvider.notifier)
        .deletePost(uuid, profileUuid);

    if (!mounted) return;
    return DialogHelper.hideLoading(context);
  }

  Future<void> onFollowTap() async {
    await ref
        .read(getProfileControllerProvider(widget.uuid!).notifier)
        .follow();

    ref.read(metadataControllerProvider(widget.uuid!).notifier).refresh();
  }

  Future<void> onUnFollowTap() async {
    await ref
        .read(getProfileControllerProvider(widget.uuid!).notifier)
        .unfollow();

    ref.read(metadataControllerProvider(widget.uuid!).notifier).refresh();
  }

  Future<void> onRefresh(String uuid) async {
    ref.read(metadataControllerProvider(uuid).notifier).refresh();
    ref.read(fabLayoutControllerProvider(uuid).notifier).refresh();

    if (widget.uuid != null) {
      ref.read(getProfileControllerProvider(widget.uuid!).notifier).refresh();
      ref.read(profileFabControllerProvider(uuid).notifier).refresh();
      ref.read(giglistProfileControllerProvider(uuid).notifier);
      ref.read(eventProfileControllerProvider(widget.uuid!).notifier).refresh();
    } else {
      await ref.read(profileControllerProvider.notifier).getProfile();
      ref.read(fabControllerProvider(uuid).notifier).refresh();
      ref.read(giglistControllerProvider.notifier).refresh();
      ref.read(selfEventControllerProvider.notifier).refresh();
    }
  }

  void onStatusTap(
    bool availabilityStatus,
    List<AvailabilityOut> availability,
  ) {
    AvailabilityRoute(
      status: availabilityStatus,
      $extra: availability,
    ).push(context);
  }

  List<GigListOut> _getGiglists(String uuid) {
    if (widget.uuid != null) {
      return ref.watch(giglistProfileControllerProvider(uuid)).valueOrNull ??
          [];
    }

    return ref.watch(giglistControllerProvider).valueOrNull?.items ?? [];
  }

  List<EventOut> _getEvents() {
    List<EventOut>? items;

    if (widget.uuid != null) {
      items =
          ref.watch(eventProfileControllerProvider(widget.uuid!)).valueOrNull;
    } else {
      items = ref.watch(selfEventControllerProvider).valueOrNull;
    }

    if (items == null) return [];

    return items
        .where((e) => e.endTime.toLocal().isBefore(DateTime.now()))
        .toList();
  }
}
