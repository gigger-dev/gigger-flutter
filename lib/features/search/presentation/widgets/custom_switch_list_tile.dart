import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/custom_list_tile.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CustomSwitchListTile extends StatelessWidget {
  const CustomSwitchListTile({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.onChanged,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: TextViewWidget(text: title),
      subtitle: subtitle == null
          ? null
          : TextViewWidget(text: subtitle!, textSize: 10),
      trailing: Transform.scale(
        scale: .8,
        child: Theme(
          data: Theme.of(context).copyWith(),
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: colorRed,
            activeTrackColor: colorTransparent,
            trackOutlineWidth: const WidgetStatePropertyAll(.5),
            trackOutlineColor: const WidgetStatePropertyAll(colorWhite),
          ),
        ),
      ),
    );
  }
}
