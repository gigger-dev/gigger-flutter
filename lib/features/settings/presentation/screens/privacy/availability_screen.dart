import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_add_user_btn.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_selector.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class AvailabilityScreen extends StatelessWidget {
  const AvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Availability',
      children: [
        SettingSelector(
          items: const [
            'Visible for All account (Free, Pro, Band)',
            'Visible for Pro account only',
            'No one can see my availablity'
          ],
          value: 1,
          onSelected: (value) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: TextViewWidget(
            text:
                'Choose who to show if you are available for collaborations, playing together or commercial offers.',
            textSize: 12,
            color: colorTextGrey,
          ),
        ),
        const SettingDivider(height: 30),
        const SizedBox(height: 30),
        SettingItem(
          title: 'Allow FREE users you follow',
          value: true,
          color: colorWhite,
          isRequiredPro: true,
          onChanged: (value) {},
        ),
        SettingItem(
          title: 'Allow FREE users who follow you',
          value: false,
          color: colorWhite,
          isRequiredPro: true,
          onChanged: (value) {},
        ),
        SettingItem(
          title: 'Allow Memberships Subscribers',
          value: true,
          color: colorWhite,
          isRequiredPro: true,
          onChanged: (value) {},
        ),
        SettingItem(
          title: 'Allow specific users only',
          value: false,
          color: colorWhite,
          isRequiredPro: true,
          onChanged: (value) {},
        ),
        const SizedBox(height: 20),
        const SettingAddUserBtn(),
        SizedBox(height: .08.sh),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextViewWidget(
            text: 'With the PRO version you can allow or deny more selectively',
            color: colorTextGrey,
            textSize: 12,
          ),
        )
      ],
    );
  }
}
