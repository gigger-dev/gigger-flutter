import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';

class PrivacyAssistanceScreen extends StatelessWidget {
  const PrivacyAssistanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Privacy assistance FAQ',
      children: [
        SettingItem(
          haveArrow: true,
          title: 'Age requirements',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Account privacy',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Location sharing',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Blocking an account',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Remove a follower',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Manage contents with you',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Who can see your S\'Up',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Account or content reporting',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Removing an account',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
      ],
    );
  }
}
