import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_add_user_btn.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CalendarPrivacyScreen extends StatelessWidget {
  const CalendarPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Calendar Privacy Settings',
      children: [
        SettingItem(
          value: false,
          title: 'Available for Free Users',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          value: true,
          autoResize: true,
          title: 'Available for Pro users and Bands',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: TextViewWidget(
            text:
                'Choose who can see your calendar. We will not show your commiments. Unavailable slots will simply be unselectable',
            textSize: 12,
            color: colorTextGrey,
          ),
        ),
        const SettingDivider(),
        const SizedBox(height: 40),
        SettingItem(
          value: false,
          autoResize: true,
          isRequiredPro: true,
          title: 'Allow FREE users you follow',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          value: false,
          autoResize: true,
          isRequiredPro: true,
          title: 'Allow FREE users who follow you',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          value: true,
          autoResize: true,
          isRequiredPro: true,
          title: 'Allow Memberships Subscribers',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          value: true,
          isRequiredPro: true,
          title: 'Allow specific users only',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        const SizedBox(height: 10),
        const SettingAddUserBtn(),
        SizedBox(height: .08.sh),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextViewWidget(
            text:
                'With these selections you can refine your choice and make the calendar available only to selected users.',
            color: colorTextGrey,
            textSize: 12,
          ),
        )
      ],
    );
  }
}
