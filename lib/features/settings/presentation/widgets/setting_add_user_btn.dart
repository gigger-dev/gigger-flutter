import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SettingAddUserBtn extends StatelessWidget {
  const SettingAddUserBtn({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.add, color: colorWhite, size: 36),
      title: TextViewWidget(
        text: title ?? 'Add users to allow list',
        textSize: 14,
      ),
      onTap: () => SheetUtils.newComingSoonSheet(context),
    );
  }
}
