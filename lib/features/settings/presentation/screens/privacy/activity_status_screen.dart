import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ActivityStatusScreen extends StatelessWidget {
  const ActivityStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Activity status',
      children: [
        SettingItem(
          value: true,
          title: 'Show your activity status',
          onChanged: (value) => SheetUtils.newComingSoonSheet(context),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: TextViewWidget(
            text:
                'Allow the accounts you follow to view your activity status and the time of your last activity. If you disable the feature, you won\'t see the activity status of other accounts.',
            color: colorTextGrey,
            textSize: 12,
          ),
        )
      ],
    );
  }
}
