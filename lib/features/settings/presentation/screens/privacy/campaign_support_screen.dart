import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CampaignSupportScreen extends StatelessWidget {
  const CampaignSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Campaign and Support',
      children: [
        SettingItem(
          value: true,
          title: 'Show that you are a supporter',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          child: TextViewWidget(
            text:
                'Your account will be shown in the campaign supporters list, but the amount will never be shown.',
            textSize: 11.5,
            color: colorTextGrey,
          ),
        )
      ],
    );
  }
}
