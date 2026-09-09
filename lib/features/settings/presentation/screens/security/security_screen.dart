import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Security',
      children: [
        SettingItem(
          title: 'Email and password',
          haveArrow: true,
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const EmailPasswordRoute().push(context);
          },
        ),
        SettingItem(
          haveArrow: true,
          title: 'Two-factors authentication',
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const TwoFactorRoute().push(context);
          },
        ),
        SettingItem(
          haveArrow: true,
          title: 'Login activity',
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const LoginActivityRoute().push(context);
          },
        ),
        SettingItem(
          haveArrow: true,
          title: 'Email from Gigger',
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const EmailFromGiggerRoute().push(context);
          },
        ),
        SettingItem(
          haveArrow: true,
          title: 'Download backup',
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const DownloadBackupRoute().push(context);
          },
        ),
      ],
    );
  }
}
