import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_selector.dart';

class DirectMessageScreen extends StatefulWidget {
  const DirectMessageScreen({super.key});

  @override
  State<DirectMessageScreen> createState() => _DirectMessageScreenState();
}

class _DirectMessageScreenState extends State<DirectMessageScreen> {
  bool messageRequest = true;
  bool receiveMessage = true;

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Direct message',
      children: [
        SettingSelector(
          items: const ['Yes', 'No'],
          value: messageRequest ? 0 : 1,
          footer: 'New message request',
          onSelected: (value) {
            messageRequest = value == 0;
            setState(() {});
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SettingDivider(),
        ),
        SettingSelector(
          items: const ['Yes', 'No'],
          value: receiveMessage ? 0 : 1,
          footer: 'Notify when you receive a new message',
          onSelected: (value) {
            receiveMessage = value == 0;
            setState(() {});
          },
        )
      ],
    );
  }
}
