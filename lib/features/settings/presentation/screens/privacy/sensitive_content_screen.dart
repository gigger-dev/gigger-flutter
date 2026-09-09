import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SensitiveContentScreen extends StatefulWidget {
  const SensitiveContentScreen({super.key});

  @override
  State<SensitiveContentScreen> createState() => _SensitiveContentScreenState();
}

class _SensitiveContentScreenState extends State<SensitiveContentScreen> {
  int value = 0;

  List<String> titles = ['Allow', 'Limit'];
  List<String> descriptions = [
    'You may see photos or videos that you may find offensive or annoying.',
    'You may see fewer photos or videos that you might find offensive or annoying.',
  ];

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Sensitive Contents',
      children: [
        const ListTile(
          dense: true,
          title: TextViewWidget(text: 'Set your preferences'),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextViewWidget(
              text:
                  'When you search the appropriate sections, we will try to limit content that we find offensive or annoying.',
              color: colorTextGrey,
              textSize: 12,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: SettingDivider(),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: titles.length,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            var data = titles[index];

            var isSelected = index == value;

            return ListTile(
              dense: true,
              title: TextViewWidget(
                text: data,
                color: isSelected ? colorTextRed : null,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextViewWidget(
                  text: descriptions[index],
                  color: colorTextGrey,
                  textSize: 12,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              trailing: !isSelected
                  ? const SizedBox(width: 20)
                  : const Icon(Icons.check, color: colorRed),
              onTap: () {
                value = index;
                setState(() {});
              },
            );
          },
        )
      ],
    );
  }
}
