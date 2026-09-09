import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_add_user_btn.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Messages',
      children: [
        SettingItem(
          title: 'All Free account users',
          value: false,
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          title: 'All Pro account users',
          value: true,
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          title: 'All Band & Collective accounts',
          value: true,
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: TextViewWidget(
            text:
                'Choose who can send messages or message requests if they are not one of your followers.',
            textSize: 12,
            color: colorTextGrey,
          ),
        ),
        const SettingDivider(height: 20),
        const SizedBox(height: 20),
        SettingItem(
          value: false,
          isRequiredPro: true,
          title: 'All FREE users you follow',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          value: false,
          autoResize: true,
          isRequiredPro: true,
          title: 'All FREE users who follow you',
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
          autoResize: true,
          isRequiredPro: true,
          title: 'Allow campaigns Supporters',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          value: false,
          autoResize: true,
          isRequiredPro: true,
          title: 'Allow specific users only',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        const SizedBox(height: 20),
        const SettingAddUserBtn(),
        SizedBox(height: .08.sh),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextViewWidget(
            text:
                'With the PRO version you can exclusively choose who can contact you and allow selected Free users.',
            color: colorTextGrey,
            textSize: 12,
          ),
        )
      ],
    );
  }
}
