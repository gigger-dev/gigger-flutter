import 'dart:io';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/helpers/aws_helper.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/save_temp_file.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/auth/data/auth_provider.dart';
import 'package:mobile_gigger_app/features/auth/domain/auth_use_case.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/interest/providers/interest_provider.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/profile_setup/providers/profile_setup_controller.dart';
import 'package:mobile_gigger_app/features/profile_setup/providers/service_provider.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/basic_info_form_sheet.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/motto_widget.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_edit_sheet.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/cancel_confirm_dialog.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/congratulation_popup.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/cover_image.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/cp_cm.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/profile_connection.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/profile_scrollbar.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/setup_tabbar.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/slide_switcher.dart';
import 'package:mobile_gigger_app/models/achievement_in.dart';
import 'package:mobile_gigger_app/models/availability_in.dart';
import 'package:mobile_gigger_app/models/availability_out.dart';
import 'package:mobile_gigger_app/models/contact_in.dart';
import 'package:mobile_gigger_app/models/education_in.dart';
import 'package:mobile_gigger_app/models/experiences_in.dart';
import 'package:mobile_gigger_app/models/file_type.dart';
import 'package:mobile_gigger_app/models/profile_in.dart';
import 'package:mobile_gigger_app/widgets/top_gradient.dart';
import 'package:mobile_gigger_app/widgets/loading_button.dart';
import 'package:mobile_gigger_app/widgets/select_media_sheet.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';

enum ProfileType {
  cover('Cover'),
  avatar('Avatar'),
  basicInfo('Basic Info'),
  availability('Availability'),
  editBio('Edit Bio'),
  motto('Motto'),
  review('Review');

  final String value;

  const ProfileType(this.value);

  bool get isCover => this == cover;
  bool get isAvatar => this == avatar;
  bool get isBasicInfo => this == basicInfo;
  bool get isAvailability => this == availability;
  bool get isEditBio => this == editBio;
  bool get isMotto => this == motto;
  bool get isReview => this == review;
}

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen>
    with TickerProviderStateMixin {
  final scrollController = ScrollController();
  final coverImageController = CustomImageCropController();

  late TabController controller;
  OverlayEntry? overlayEntry;

  double get getOffset {
    if (!scrollController.hasClients) return 0;
    return scrollController.offset;
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: ProfileType.values.length, vsync: this);
    scrollController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    ref.read(serviceProvider);
    var name =
        ref.watch(authControllerProvider).whenData((v) => v.username).value!;

    var state = ref.watch(profileSetupControllerProvider);

    bool isLast = state.profileType.isReview;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) async => await showConfirmDialog(),
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: SizedBox(
          height: 84,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LoadingButton(
              isLoading: state.isLoading,
              loadingMsg: state.loadingMsg,
              title: isLast ? 'Save and enjoy Gigger' : 'Continue',
              onPressed: () => isLast ? onSave(state) : onContinue(state),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: SlideSwitcher(
                child: Stack(
                  key: ValueKey(state.profileType.index),
                  children: [
                    if (!state.profileType.isMotto)
                      CoverImage(
                        onTap: onCoverImageTap,
                        onRemove: onCoverImageRemove,
                        isCover: state.profileType.isCover,
                        cropController: coverImageController,
                        coverImageFile: state.coverImageFile,
                        coverImageFinalFile: state.coverImageFinalFile,
                      ),
                    if (!state.profileType.isCover)
                      TopGradient(height: 0.65.sh),
                    ProfileScrollBar(
                      isLast: isLast,
                      controller: scrollController,
                      isCover: state.profileType.isCover,
                      offset: state.profileType.isReview ? getOffset : 0,
                      children: state.profileType.isMotto
                          ? [
                              MottoWidget(
                                key: ValueKey(state.profileType.index),
                              )
                            ]
                          : [
                              ProfileConnection(
                                name: name,
                                state: state,
                                isLast: isLast,
                                onEditDioTap: onEditDioTap,
                                onProfileTap: onProfileTap,
                                onBasicInfoTap: onBasicInfoTap,
                                onAvailabilityTap: onAvailabilityTap,
                              ),
                              CpCm(
                                isLast: isLast,
                                customPhrase: state.customPhrase,
                                closingMessage: state.closingMessage,
                              ),
                            ],
                    ),
                  ],
                ),
              ),
            ),
            SetupTabBar(
              onTap: onTapBarTap,
              controller: controller,
              current: state.profileType.index,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onBasicInfoTap(String name) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorTransparent,
      builder: (_) => BasicInfoFormSheet(name: name),
    );
  }

  Future<void> onCoverImageTap() async {
    var path = await SheetUtils.showSimpleSheet<String>(
      context: context,
      child: const SelectMediaSheet.image(title: 'Select Cover Image'),
    );

    if (path == null) return;

    ref
        .read(profileSetupControllerProvider.notifier)
        .coverImageFile(File(path));
  }

  Future<void> onProfileTap() async {
    var path = await SheetUtils.showSimpleSheet<String>(
      context: context,
      child: const SelectMediaSheet.image(
        title: 'Select Profile Image',
      ),
    );

    if (path == null) return;
    if (!mounted) return;

    var profileImage = await showModalBottomSheet<MemoryImage>(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.grey.shade900,
      builder: (_) => ProfileEditSheet(file: File(path)),
    );

    if (profileImage == null) return;

    ref
        .read(profileSetupControllerProvider.notifier)
        .profileImageFile(profileImage);
  }

  Future<void> onEditDioTap(ProfileSetupState state) async {
    var data = await showModalBottomSheet<List>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey.shade900,
      builder: (_) => const EditBioSheet(),
    );

    if (data == null) return;

    onContinue(state);
  }

  Future<void> onSave(ProfileSetupState state) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => CongratulationPopup(),
    );

    isLoading(true);
    loadingMsg('Profile Image Uploading');

    showLoading();

    String? profileR;

    // var repo = ref.read(fileUploadRepoProvider);

    try {
      var file = await saveTempFile(
        bytes: state.profileImageFile!.bytes,
        name: 'profile.png',
      );

      profileR = (await AwsHelper.upload(
        path: file.path,
        fileType: FileType.profile,
      ))!;

      // profileR = await postApiV1FileUploadUseCase(
      //   fileType: FileType.profile,
      //   file: file,
      //   repo: repo,
      // );
    } catch (e) {
      Toast.error(e.toString());

      hideLoading();

      loadingMsg('Profile Image Upload Fail');

      await Future.delayed(const Duration(seconds: 1));

      isLoading(false);
      return;
    }

    String? coverR;

    loadingMsg('Cover Image Uploading');

    try {
      var file = await saveTempFile(
        bytes: state.coverImageFinalFile!.bytes,
        name: 'cover.png',
      );

      coverR =
          (await AwsHelper.upload(path: file.path, fileType: FileType.cover))!;

      // coverR = await postApiV1FileUploadUseCase(
      //   fileType: FileType.cover,
      //   file: file,
      //   repo: repo,
      // );
    } catch (e) {
      Toast.error(e.toString());

      hideLoading();

      loadingMsg('Cover Image Upload Fail');

      await Future.delayed(const Duration(seconds: 1));

      isLoading(false);

      return;
    }

    try {
      var interests =
          ref.read(interestProvider).whenData((v) => v.selectedList).value ??
              [];

      loadingMsg('Profile Creating');

      var contacts = state.contacts.keys.map((e) {
        return ContactIn(value: state.contacts[e]!.text.trim(), type: e);
      }).toList();

      var experiences = state.experiences.map((e) {
        return ExperiencesIn(name: e.text.trim(), category: '');
      }).toList();

      var educations = state.studies.map((e) {
        return EducationIn(name: e.text.trim(), url: '');
      }).toList();

      var achievements = state.achievements.map((e) {
        return AchievementIn(name: e.text.trim(), category: '', url: '');
      }).toList();

      var availability = state.availability;

      var me = await getApiV1AccountsMeUseCase(ref.read(authRepoProvider));

      var model = ProfileIn(
        bio: state.bio,
        contacts: contacts,
        coverMedia: coverR,
        accountUuid: me.uuid,
        avatarMedia: profileR,
        educations: educations,
        experiences: experiences,
        services: state.services,
        location: state.location!,
        availability: availability,
        achievements: achievements,
        socialLinks: state.socialLinks,
        customPhrase: state.customPhrase ?? '',
        closingMessage: state.closingMessage ?? '',
        availabilityStatus: state.availabilityStatus,
        interests: interests.map((e) => e.uuid).toList(),
        skills: state.skills.map((e) => e.uuid).toList(),
      );

      await ref.read(profileControllerProvider.notifier).createProfile(
        model,
        me,
        () {
          hideLoading();
          isLoading(false);
          loadingMsg('Profile Create Success');
        },
        (e) {
          Toast.error(e);

          hideLoading();

          loadingMsg('Profile Create Failed');

          isLoading(false);
        },
      );
    } catch (e) {
      Toast.error(e.toString());

      hideLoading();

      loadingMsg('Profile Create Failed');

      isLoading(false);
    }
  }

  Future<void> onContinue(ProfileSetupState state) async {
    isLoading(true);

    if (state.profileType.isCover) {
      if (state.coverImageFile == null && state.coverImageFinalFile == null) {
        return isLoading(false);
      }

      if (state.coverImageFinalFile == null) {
        ref
            .read(profileSetupControllerProvider.notifier)
            .coverImageFinalFile(await coverImageController.onCropImage());
      }

      ref.read(profileSetupControllerProvider.notifier).coverImageFile(null);
    }

    if (state.profileType.isAvatar) {
      if (state.profileImageFile == null) return isLoading(false);
    }

    if (state.profileType.isBasicInfo) {
      if (state.skills.isEmpty || state.location == null) {
        await Toast.error('Required fields cannot be empty');
        return isLoading(false);
      }
    }

    if (state.profileType.isEditBio) {
      if (state.bio.isEmpty) {
        await Toast.error('Bio cannot be empty');
        return isLoading(false);
      }
    }

    var current = state.profileType.index + 1;

    controller.animateTo(current);

    var type = ProfileType.values[current];

    ref.read(profileSetupControllerProvider.notifier).profileType(type);

    try {
      scrollController.animateTo(
        type.isEditBio ? 100 : 0,
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    } catch (_) {}

    isLoading(false);
  }

  void onTapBarTap(int value, int current) {
    if (value < current) {
      current = value;
      controller.index = current;

      var type = ProfileType.values[current];

      ref.read(profileSetupControllerProvider.notifier).profileType(type);

      scrollController.animateTo(
        type.isEditBio ? 100 : 0,
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      );

      return;
    }

    controller.animateTo(current);
  }

  Future<void> showConfirmDialog() async {
    await SheetUtils.showSheet(
      // height: .6.sh,
      context: context,
      showAction: false,
      isScrollControlled: true,
      // padding: EdgeInsets.all(20),
      actionPadding: EdgeInsets.all(20),
      children: [CancelConfirmDialog()],
    );
  }

  void showLoading() {
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned.fill(
        child: Container(
          color: colorBlack.withOpacity(.5),
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: colorRed,
              ),
              padding: const EdgeInsets.all(6),
              child: Transform.scale(
                scale: .6,
                child: const CircularProgressIndicator(color: colorWhite),
              ),
            ),
          ),
        ),
      );
    });

    setState(() {});

    Overlay.of(context).insert(overlayEntry!);
  }

  void hideLoading() {
    overlayEntry?.remove();

    overlayEntry = null;
    if (!mounted) return;
    setState(() {});
  }

  Future<void> onAvailabilityTap({
    required bool status,
    required List<AvailabilityIn> availability,
  }) async {
    var data = await AvailabilityRoute(
      status: status,
      viewOnly: false,
      $extra: availability
          .map((e) => AvailabilityOut.fromJson(e.toJson()))
          .toList(),
    ).push<List>(context);

    if (data == null) return;

    ref.read(profileSetupControllerProvider.notifier).availability(
          status: data[0],
          availability: data[1],
        );
  }

  void loadingMsg(String msg) {
    ref.read(profileSetupControllerProvider.notifier).loadingMsg(msg);
  }

  void isLoading(bool value) {
    ref.read(profileSetupControllerProvider.notifier).isLoading(value);
  }

  void onCoverImageRemove() {
    ref.read(profileSetupControllerProvider.notifier).removeCoverImage();
  }
}
