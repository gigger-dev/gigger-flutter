import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class EmailFromGiggerScreen extends StatelessWidget {
  const EmailFromGiggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingPage(
      title: 'Emails from Gigger',
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: TextViewWidget(
            text:
                'Here you will find all the emails we have sent you in the last 14 days regarding the communications and changes you have made on your account.',
            textSize: 11.5,
            color: colorTextGrey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SettingDivider(),
        ),
        ListTile(
          title: TextViewWidget(
            text: 'Password changed successfully. You c...',
            textSize: 13,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextViewWidget(
                text: '24 Sept 2022 - 3.22pm',
                textSize: 11,
              ),
              SizedBox(height: 4),
              TextViewWidget(
                text: 'Sent to: aleddd@gmail.com',
                textSize: 11,
                color: colorTextGrey,
              ),
            ],
          ),
        ),
        ListTile(
          title: TextViewWidget(
            text: 'Password changed successfully. You c...',
            textSize: 13,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextViewWidget(
                text: '12 Sept 2022 - 3.22pm',
                textSize: 11,
              ),
              SizedBox(height: 4),
              TextViewWidget(
                text: 'Sent to: aleddd@gmail.com',
                textSize: 11,
                color: colorTextGrey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
