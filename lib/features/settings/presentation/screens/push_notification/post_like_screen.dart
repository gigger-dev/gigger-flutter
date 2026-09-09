import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_selector.dart';

class PostLikeScreen extends StatefulWidget {
  const PostLikeScreen({super.key});

  @override
  State<PostLikeScreen> createState() => _PostLikeScreenState();
}

class _PostLikeScreenState extends State<PostLikeScreen> {
  int likeContent = 0;
  int tagContent = 0;
  int likeTagContent = 0;

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Post, likes and S\'Up',
      children: [
        SettingSelector(
          footer: 'Notifications when someone likes your content',
          items: const [
            'All users (Free, Pro, Band)',
            'Following and followers',
            'No'
          ],
          value: likeContent,
          onSelected: (value) {
            likeContent = value;
            setState(() {});
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: SettingDivider(),
        ),
        SettingSelector(
          footer: 'Notifications when someone tag you in their content',
          items: const [
            'All users (Free, Pro, Band)',
            'Following and followers',
            'No'
          ],
          value: tagContent,
          onSelected: (value) {
            tagContent = value;
            setState(() {});
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: SettingDivider(),
        ),
        SettingSelector(
          footer: 'When someone likes the content you are tagged in',
          items: const [
            'All users (Free, Pro, Band)',
            'Following and followers',
            'No'
          ],
          value: likeTagContent,
          onSelected: (value) {
            likeTagContent = value;
            setState(() {});
          },
        ),
      ],
    );
  }
}
