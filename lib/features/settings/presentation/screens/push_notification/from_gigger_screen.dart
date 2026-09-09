import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_selector.dart';

class FromGiggerScreen extends StatelessWidget {
  const FromGiggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'From Gigger',
      children: [
        SettingSelector(
          value: 0,
          items: const ['Yes', 'No'],
          footer: 'Updating on your request for assistance',
          onSelected: (value) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SettingDivider(),
        ),
        SettingSelector(
          value: 0,
          items: const ['Yes', 'No'],
          footer: 'Send notification for unrecognized logins',
          onSelected: (value) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SettingDivider(),
        ),
        SettingSelector(
          value: 0,
          items: const ['Yes', 'No'],
          footer: 'Memorandum',
          onSelected: (value) {},
        ),
      ],
    );
  }
}
