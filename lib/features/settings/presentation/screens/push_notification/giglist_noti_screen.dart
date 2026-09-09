import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';

class GiglistNotiScreen extends StatelessWidget {
  const GiglistNotiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Giglist notifications',
      children: [
        SettingItem(
          value: true,
          onChanged: (value) {},
          title: 'Reply from users (Specific DM)',
        ),
        SettingItem(
          value: true,
          onChanged: (value) {},
          title: 'New add from following',
        ),
        SettingItem(
          value: true,
          onChanged: (value) {},
          title: 'Favorites changes',
        ),
        SettingItem(
          value: true,
          onChanged: (value) {},
          title: 'Special offers suggested for you',
        ),
      ],
    );
  }
}
