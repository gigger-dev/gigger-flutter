import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SupportDonationScreen extends StatelessWidget {
  const SupportDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Support and donations from users',
      children: [
        const SettingItem(title: 'Notify donations'),
        SettingItem(
          title: 'From FREE users',
          value: true,
          onChanged: (value) {},
        ),
        SettingItem(
          title: 'From PRO and band',
          value: true,
          onChanged: (value) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SettingDivider(),
        ),
        const SettingItem(title: 'Notify support'),
        SettingItem(
          title: 'From FREE users',
          value: true,
          onChanged: (value) {},
        ),
        SettingItem(
          title: 'From PRO and band',
          value: true,
          onChanged: (value) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SettingDivider(),
        ),
        SettingItem(
          title: 'Send automatic DM to say Thank You',
          value: true,
          onChanged: (value) {},
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: TextField(
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              hintStyle: TextStyle(fontSize: 13),
              hintText: 'Write your Thank You here ...',
            ),
          ),
        ),
        SizedBox(height: .08.sh),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: TextViewWidget(
            text:
                'Notify when you receive donations or support for your content, campaign or event. Don\'t miss the opportunity to thank those who support you with an automatic Thank You.',
            textSize: 12,
            color: colorTextGrey,
          ),
        )
      ],
    );
  }
}
