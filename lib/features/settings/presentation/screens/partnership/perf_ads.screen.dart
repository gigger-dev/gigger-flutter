import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class PerfAdsScreen extends StatelessWidget {
  const PerfAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Preferences on ads',
      children: [
        SettingItem(
          value: false,
          title: 'Fewer pets',
          onChanged: (value) {},
        ),
        SettingItem(
          value: true,
          title: 'Fewer alcohol',
          onChanged: (value) {},
        ),
        SettingItem(
          value: true,
          title: 'Fewer political thematics',
          onChanged: (value) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: TextViewWidget(
            text:
                'Choose what to show less in the advertisements we offer you. Gigger always tries to offer the best experience by monitoring the contents.',
            textSize: 12,
            color: colorTextGrey,
          ),
        ),
        const SettingDivider(),
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: TextViewWidget(
            text:
                'We use data provided by our partners and your activities to suggest advertisements that may represent your interests.',
            textSize: 12,
            color: colorTextGrey,
          ),
        ),
        SettingItem(
          title: 'Personalized advertisement',
          subtitle: 'Recommended option for more relevant adverts',
          value: true,
          color: colorWhite,
          onChanged: (value) {},
        ),
        SizedBox(height: .06.sh),
        Center(
          child: Column(
            children: [
              const TextViewWidget(
                text: 'Your data will never be sold to third parties.',
                color: colorTextGrey,
                textSize: 12,
              ),
              TextButton(
                onPressed: () {},
                child: const TextViewWidget(
                  text: 'Learn more',
                  color: colorRed,
                  textSize: 14,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
