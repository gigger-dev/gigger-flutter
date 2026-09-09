import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_selector.dart';

class FollowingFollowerScreen extends StatefulWidget {
  const FollowingFollowerScreen({super.key});

  @override
  State<FollowingFollowerScreen> createState() =>
      _FollowingFollowerScreenState();
}

class _FollowingFollowerScreenState extends State<FollowingFollowerScreen> {
  bool notifyNewFollower = true;
  bool notifyUserAccept = true;
  bool notifySuggestion = true;
  int notifyMention = 2;

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Following and followers',
      children: [
        SettingSelector(
          items: const ['Yes', 'No'],
          footer: 'Notify new followers',
          value: notifyNewFollower ? 0 : 1,
          onSelected: (value) {
            notifyNewFollower = value == 0;
            setState(() {});
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SettingDivider(),
        ),
        SettingSelector(
          items: const ['Yes', 'No'],
          footer: 'Notify when users accept your following request',
          value: notifyUserAccept ? 0 : 1,
          onSelected: (value) {
            notifyUserAccept = value == 0;
            setState(() {});
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SettingDivider(),
        ),
        SettingSelector(
          items: const ['Yes', 'No'],
          footer: 'Notify account suggestions you may know',
          value: notifySuggestion ? 0 : 1,
          onSelected: (value) {
            notifySuggestion = value == 0;
            setState(() {});
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SettingDivider(),
        ),
        SettingSelector(
          items: const ['Yes', 'No', 'Following accounts only'],
          footer: 'Notify when you are mentioned in user\'s bio',
          value: notifyMention,
          onSelected: (value) {
            notifyMention = value;
            setState(() {});
          },
        ),
      ],
    );
  }
}
