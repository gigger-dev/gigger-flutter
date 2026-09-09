import 'package:flutter/material.dart';

import 'package:mobile_gigger_app/features/search/presentation/widgets/custom_list_tile.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class RadioListTile extends StatelessWidget {
  const RadioListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String title;
  final String? subtitle;
  final int value;
  final int groupValue;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () => onChanged(value),
      title: TextViewWidget(text: title),
      subtitle: subtitle == null
          ? null
          : TextViewWidget(text: subtitle!, textSize: 10),
      trailing: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: (v) => onChanged(v!),
      ),
    );
  }
}
