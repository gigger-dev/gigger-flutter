import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var username = ref.watch(
        profileControllerProvider.select((v) => v.value?.account.username));

    return SettingPage(
      title: 'Settings',
      children: [
        SettingItem(
          title: 'Manage my account',
          onTap: () => const ManageAccountRoute().push(context),
        ),
        SettingItem(
          title: 'Privacy',
          onTap: () => const PrivacyRoute().push(context),
        ),
        SettingItem(
          title: 'Security',
          onTap: () => const SecurityRoute().push(context),
        ),
        const SettingDivider(),
        SettingItem(
          title: 'Push notifications',
          onTap: () => const PushNotificationRoute().push(context),
        ),
        SettingItem(
          title: 'Your advertisements / Partnerships',
          onTap: () => const PartnershipRoute().push(context),
        ),
        SettingItem(
          title: 'Customize interface & theme',
          isRequiredPro: true,
          trailing: const SizedBox(),
          onTap: () => const CustomizeThemeRoute().push(context),
        ),
        // const SettingItem(title: 'Theme'),
        const SettingDivider(),
        SettingItem(
          title: 'Support',
          onTap: () => const SupportSettingRoute().push(context),
        ),
        SettingItem(
          title: 'Subscribe to Gigger Pro',
          color: colorRed,
          onTap: () => const SubscribeRoute().push(context),
        ),
        const SettingDivider(),

        SettingItem(
          title: 'Logout from $username',
          onTap: () async {
            DialogHelper.showLoadingDialog(context);
            await ref.read(authControllerProvider.notifier).logout();

            if (!context.mounted) return;

            DialogHelper.hideLoading(context);
          },
        ),
        SettingItem(
          title: 'Logout from any account',
          isRequiredPro: true,
          trailing: const SizedBox(),
          onTap: () async {
            DialogHelper.showLoadingDialog(context);
            await ref.read(authControllerProvider.notifier).logout();

            if (!context.mounted) return;

            DialogHelper.hideLoading(context);
          },
        ),
        const SettingDivider(),
        FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null) return SizedBox();

            return SettingItem(
              title: 'App Version',
              trailing: TextViewWidget(
                text: '${data.version}+${data.buildNumber}',
              ),
            );
          },
        ),
      ],
    );
  }
}
