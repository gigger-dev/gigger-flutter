import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_add_user_btn.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';

class PartnershipSettingScreen extends StatelessWidget {
  const PartnershipSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingPage(
      title: 'Partnerships',
      children: [
        SettingItem(
          spacing: 0,
          horizontal: 16,
          title: 'Your business partners',
          description:
              'The list of your commercial collaborations and links to their dedicated page',
        ),
        SizedBox(height: 50),
        SettingItem(title: 'Thomann', haveArrow: true),
        SettingItem(title: 'Harley Benton', haveArrow: true),
        SettingItem(title: 'Amazon Music', haveArrow: true),
        SettingItem(title: 'GHS', haveArrow: true),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: SettingDivider(),
        ),
        SettingAddUserBtn(
          title: 'Add new business partnership',
        ),
      ],
    );
  }
}
