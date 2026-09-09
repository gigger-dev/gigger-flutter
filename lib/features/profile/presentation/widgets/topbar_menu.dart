import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/utils/convert_video_to_gif.dart';
import 'package:mobile_gigger_app/core/utils/get_share_url.dart';
import 'package:mobile_gigger_app/features/main/providers/main_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/video_trim_dialog.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_draft_layout_controller.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/basic_info_form_sheet.dart';
import 'package:mobile_gigger_app/models/location_in.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';
import 'package:mobile_gigger_app/widgets/popup_btn.dart';
import 'package:path/path.dart' as p;

import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_edit_controller.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_edit_sheet.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/select_media_sheet.dart';
import 'package:popover/popover.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

typedef ProfileChanged = void Function(MemoryImage image, String name);

class TopbarMenu extends ConsumerWidget {
  const TopbarMenu({
    super.key,
    required this.isEditMode,
    required this.isCoverEdit,
    required this.isOwner,
    required this.onProfileChanged,
    required this.profile,
    required this.location,
    required this.avatarMedia,
  });

  final bool isOwner;
  final bool isEditMode;
  final bool isCoverEdit;
  final String avatarMedia;
  final ProfileOut profile;
  final LocationIn location;
  final ProfileChanged onProfileChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedPositioned(
      left: 0,
      right: 0,
      top: 0,
      duration: const Duration(milliseconds: 400),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, -1),
              end: const Offset(0, 0),
            ).animate(animation),
            child: child,
          );
        },
        child: isEditMode || isCoverEdit
            ? const SizedBox(key: ValueKey('profile_menubar_hide'))
            : Container(
                key: const ValueKey('profile_menubar'),
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: InkWell(
                        onTap: () => onBack(ref, context),
                        child: Icon(Icons.arrow_back_ios, color: colorWhite),
                      ),
                    ),
                    InkWell(
                      onTap: () => onShareTap(context),
                      child: Image.asset(
                        Assets.images.giShare.path,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (isOwner) {
                          NotiRoute(index: 1).push(context);
                          // ChatListRoute().push(context);
                        } else {
                          ChatRoute(uuid: profile.uuid).push(context);
                        }
                      },
                      child: Image.asset(
                        Assets.images.giMessage.path,
                        width: 25,
                        height: 25,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (isOwner) {
                          NotiRoute(index: 2).push(context);
                        } else {
                          SupportRoute(profile).push(context);
                        }
                      },
                      child: Image.asset(
                        Assets.images.giSupport.path,
                        width: 25,
                        height: 25,
                      ),
                    ),
                    if (isOwner)
                      PopupBtn(
                        width: .5.sw,
                        key: ValueKey('owner_menu_btn'),
                        direction: PopoverDirection.bottom,
                        icon: Icon(
                          Icons.menu,
                          color: colorWhite,
                          semanticLabel: 'menu',
                        ),
                        items: [
                          PopupItem(
                            title: 'Settings',
                            onTap: () => SettingRoute().push(context),
                          ),
                          PopupItem(
                            title: 'Update Avatar',
                            onTap: () => onUpdateAvatar(context),
                          ),
                          PopupItem(
                            title: 'Update Cover',
                            onTap: () => onUpdateCover(ref, context),
                          ),
                          PopupItem(
                            title: 'Modify Profile',
                            onTap: () => _onModifyProfile(ref),
                          ),
                          PopupItem(
                            title: 'Update basic info',
                            onTap: () => onUpdateBasicInfo(context),
                          ),
                          PopupItem(
                            title: "Create a S'Up for this",
                            onTap: () => createSup(context, ref),
                          ),
                          PopupItem(
                            title: 'Copy account link',
                            onTap: onCopyAccountLink,
                          ),
                          PopupItem(
                            title: 'Boost my profile!',
                            onTap: () => SheetUtils.newComingSoonSheet(context),
                          ),
                        ],
                      )
                    else
                      PopupBtn(
                        width: .5.sw,
                        key: ValueKey('visitor_menu_btn'),
                        direction: PopoverDirection.bottom,
                        icon: Icon(Icons.more_horiz, color: colorWhite),
                        items: [
                          PopupItem(
                            title: 'Send DM',
                            onTap: () {
                              ChatRoute(uuid: profile.uuid).push(context);
                            },
                          ),
                          PopupItem(
                            title: 'Share it',
                            onTap: () => onShareTap(context),
                          ),
                          PopupItem(
                            title: 'Support user',
                            onTap: () => SheetUtils.newComingSoonSheet(context),
                          ),
                          PopupItem(
                            title: 'Report a problem',
                            onTap: () => SheetUtils.newComingSoonSheet(context),
                          ),
                        ],
                      )
                  ],
                ),
              ),
      ),
    );
  }

  void onShareTap(BuildContext context) {
    Share.share('Check out this profile ${getProfileShareUrl(profile.uuid)}');
  }

  Future<void> onUpdateAvatar(BuildContext context) async {
    var path = await SheetUtils.showSimpleSheet<String>(
      context: context,
      child: SelectMediaSheet.image(title: 'Select Profile Image'),
    );

    if (path == null || !context.mounted) return;

    var profileImage = await showModalBottomSheet<MemoryImage>(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.grey.shade900,
      builder: (_) => ProfileEditSheet(file: File(path)),
    );

    if (profileImage == null) return;

    onProfileChanged(profileImage, p.basename(path));
  }

  Future<void> onUpdateCover(WidgetRef ref, BuildContext context) async {
    var file = await SheetUtils.showSimpleSheet<AssetEntity>(
      context: context,
      child: SelectMediaSheet.both(title: 'Select Cover Image'),
    );

    var _file = await file?.file;

    if (file == null || _file == null || !context.mounted) return;

    if (file.mimeType!.startsWith('image')) {
      ref.read(profileEditControllerProvider.notifier).cover(_file, file.size);
      return;
    }

    var completeFile = await showDialog<File>(
      context: context,
      builder: (_) => VideoTrimDialog(
        _file,
        maxDuration: 6,
        onCallBack: (file) => convertVideoToGif(
          videoPath: file.path,
          fileName: '${p.basenameWithoutExtension(file.path)}.gif',
        ),
      ),
    );

    // if (trimFile == null) return;

    // var gif = await convertVideoToGif(
    //   videoPath: trimFile.path,
    //   fileName: '${p.basenameWithoutExtension(trimFile.path)}.gif',
    // );

    if (completeFile == null) return;

    ref
        .read(profileEditControllerProvider.notifier)
        .cover(completeFile, file.size);
  }

  void _onModifyProfile(WidgetRef ref) {
    ref.read(profileEditControllerProvider.notifier).startEdit();
  }

  Future<void> onUpdateBasicInfo(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorTransparent,
      builder: (_) => BasicInfoFormSheet(
        isModify: true,
        location: location,
        skills: profile.skills,
        avatarMedia: avatarMedia,
        name: profile.account.username,
      ),
    );
  }

  void onCopyAccountLink() {
    Clipboard.setData(ClipboardData(text: getProfileShareUrl(profile.uuid)));
  }

  void onBack(WidgetRef ref, BuildContext context) {
    ref.read(mainControllerProvider.notifier).bottom(0);
    ref.read(profileEditControllerProvider.notifier).dismiss();
    ref.read(fabDraftLayoutControllerProvider(profile.uuid).notifier).reset();

    if (context.canPop()) context.pop();
  }

  void createSup(BuildContext context, WidgetRef ref) {
    ref.read(postFormControllerProvider.notifier)
      ..type(ContentType.sup)
      ..createdFrom(SupCreatedFromEnum.artist);

    PostFormRoute().push(context);
  }
}
