import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_selector.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  int canTag = 0;
  int canShare = 0;

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Post',
      children: [
        ItemList(
          value: canTag,
          title: 'Who can tag you',
          onChanged: (int value) {
            canTag = value;
            setState(() {});
          },
        ),
        const SettingDivider(height: 80),
        ItemList(
          value: canShare,
          title: 'Who can share your posts?',
          onChanged: (int value) {
            canShare = value;
            setState(() {});
          },
        ),
      ],
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
  });

  final int value;
  final String title;
  final ValueChanged<int> onChanged;

  List<String> get items => [
        'All account (Free, Pro, Band/collective)',
        'Pro and Band accounts Only',
        'Account you follow',
        'Nobody'
      ];

  @override
  Widget build(BuildContext context) {
    return SettingSelector(
      items: items,
      value: value,
      title: title,
      onSelected: onChanged,
    );
  }
}
