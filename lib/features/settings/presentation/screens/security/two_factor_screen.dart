import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_selector.dart';

class TwoFactorScreen extends StatefulWidget {
  const TwoFactorScreen({super.key});

  @override
  State<TwoFactorScreen> createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends State<TwoFactorScreen> {
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Two-Factor',
      children: [
        SettingItem(
          value: isAuth,
          title: 'Two-Factors authentication',
          description:
              'When you log in from an unknown device, you will be asked to enter a verification code.\nChoose how to receive it.',
          onChanged: (value) {
            isAuth = value;
            setState(() {});
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: SettingDivider(),
        ),
        SettingSelector(
          items: const ['Send email to your address'],
          value: isAuth ? 0 : -1,
          onSelected: (value) {
            isAuth = !isAuth;
            setState(() {});
          },
        )
      ],
    );
  }
}
