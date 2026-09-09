import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_edit_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ManageAccountScreen extends ConsumerStatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  ConsumerState<ManageAccountScreen> createState() =>
      _ManageAccountScreenState();
}

class _ManageAccountScreenState extends ConsumerState<ManageAccountScreen> {
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(profileControllerProvider).value!;

    return SettingPage(
      title: 'Manage my account',
      children: [
        SettingItem(
          title: 'Edit Profile & Bio',
          onTap: () async {
            await ProfileRoute(isInitialEdit: true).push(context);
            ref.read(profileEditControllerProvider.notifier).dismiss();
          },
        ),
        SettingItem(
          title: 'Share Profile',
          onTap: () {
            SheetUtils.shareContentSheet(
              uuid: user.uuid,
              context: context,
              title: 'Share your profile',
            );
          },
        ),
        SettingItem(
          title: 'Add New Account',
          isRequiredPro: true,
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        const SettingDivider(),
        SettingItem(
          title: 'Language',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          title: 'Browser settings',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          isRequiredPro: true,
          title: 'Verify your account',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        const SettingDivider(),
        SettingItem(
          haveArrow: true,
          title: 'Go to your Control Room',
          onTap: () => ControlRoomRoute().push(context),
        ),
        SettingItem(
          haveArrow: true,
          color: colorWhite,
          isRequiredPro: true,
          title: 'Purchase more archive space',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        const SettingDivider(),
        SettingItem(
          color: Colors.red,
          title: 'Delete Account',
          onTap: onDeleteAccountTap,
        )
      ],
    );
  }

  Future<void> onDeleteAccountTap() async {
    var result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirm Delete',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        content: TextViewWidget(
          text:
              "Are you sure you want to delete?\nThis action can't be undone.",
          textSize: 14,
          textAlign: TextAlign.center,
        ),
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        actions: [
          TextButton(
            onPressed: context.pop,
            child: TextViewWidget(text: 'Cancel'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: TextViewWidget(
              text: 'Delete',
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
    if (result == true) {
      onDeleteTap();
    }
  }

  Future<void> onDeleteTap() async {
    DialogHelper.showLoadingDialog(context, message: 'Deleting...');
    await ref.read(authControllerProvider.notifier).deleteAccount();

    if (!mounted) return;
    DialogHelper.hideLoading(context);
  }
}
