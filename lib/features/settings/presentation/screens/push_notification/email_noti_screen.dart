import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';

class EmailNotiScreen extends StatelessWidget {
  const EmailNotiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Emails notifications',
      children: [
        SettingItem(
          title: 'Emails on memorandum',
          value: false,
          onChanged: (value) {},
        ),
        SettingItem(
          title: 'Emails on assistance',
          value: true,
          onChanged: (value) {},
        ),
        SettingItem(
          title: 'Emails on news on Gigger',
          value: true,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
