import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_add_user_btn.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class MyArchiveScreen extends StatelessWidget {
  const MyArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Who can see my Archive',
      children: [
        SettingItem(
          title: 'Available for Free Users',
          value: false,
          isRequiredPro: true,
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          value: false,
          autoResize: true,
          title: 'Available for Pro users and Bands',
          isRequiredPro: true,
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(14, 20, 14, 40),
          child: TextViewWidget(
            text:
                'Choose who can see your archive. This is set on not visible by default.',
            color: colorTextGrey,
            textSize: 12,
          ),
        ),
        const SettingDivider(height: 40),
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
        const SizedBox(height: 20),
        const SettingAddUserBtn(),
        SizedBox(height: .08.sh),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextViewWidget(
            text:
                'With these selectors you can refine your choice and make Archive contents visible only to selected users.',
            color: colorTextGrey,
            textSize: 11.5,
          ),
        )
      ],
    );
  }
}
