import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';

class CustomizeThemeScreen extends StatelessWidget {
  const CustomizeThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Customize interface & theme',
      children: [
        SettingItem(
          spacing: 0,
          autoResize: true,
          title: 'Next upcoming events on Home',
          description:
              'Activate the summary of the next three upcoming events registered on your calendar',
          isRequiredPro: true,
          value: false,
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        const SettingDivider(height: 50),
        SettingItem(
          spacing: 0,
          title: 'Left-handed mode',
          description:
              'Changed some icon and action placements for a better experience and ease of use for left-handed users',
          value: false,
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SettingDivider(height: 50),
        ),
        SettingItem(
          spacing: 0,
          title: 'Gigger\'s motivational!',
          description:
              'Enjoy a new welcome for every new access on Gigger! Greetings from your personal manager',
          value: true,
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SettingDivider(height: 50),
        ),
        SettingItem(
          title: 'Change accent color',
          haveArrow: true,
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Preview format of your FAB9s\n(soon available)',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
      ],
    );
  }
}
