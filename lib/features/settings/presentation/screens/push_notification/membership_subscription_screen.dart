import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class MembershipSubscriptionScreen extends StatelessWidget {
  const MembershipSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Membership subscriptions',
      children: [
        SettingItem(
          title: 'Notify new membership subscription',
          value: true,
          onChanged: (value) {},
        ),
        SettingItem(
          value: false,
          autoResize: true,
          title: 'Notify if someone renounces membership',
          onChanged: (value) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: SettingDivider(),
        ),
        SizedBox(height: .02.sh),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: TextViewWidget(
            text:
                'We will send a notification for each new subscription to your membership or gated content.',
            textSize: 12,
            color: colorTextGrey,
          ),
        )
      ],
    );
  }
}
