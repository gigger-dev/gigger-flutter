import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_selector.dart';

class MentionScreen extends StatefulWidget {
  const MentionScreen({super.key});

  @override
  State<MentionScreen> createState() => _MentionScreenState();
}

class _MentionScreenState extends State<MentionScreen> {
  int value = 0;

  List<String> get items => [
        'All account (Free, Pro, Band/collective)',
        'Pro and Band accounts Only',
        'Account you follow',
        'Nobody'
      ];

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Mentions',
      children: [
        SettingSelector(
          items: items,
          value: value,
          title: 'Who can mentions you?',
          description:
              'Choose who can mention you in posts. S\'Up, classified, announcements, captions and descriptions.',
          onSelected: (value) {
            this.value = value;
            setState(() {});
          },
        ),
      ],
    );
  }
}
