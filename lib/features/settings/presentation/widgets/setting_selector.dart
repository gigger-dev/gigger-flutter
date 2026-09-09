import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SettingSelector extends StatelessWidget {
  const SettingSelector({
    super.key,
    required this.items,
    required this.value,
    required this.onSelected,
    this.title,
    this.description,
    this.footer,
  });

  final String? title;
  final String? description;
  final String? footer;

  final int value;
  final List<String> items;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              dense: true,
              title: TextViewWidget(text: title!, textSize: 14),
              subtitle: description == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextViewWidget(
                        text: description!,
                        color: colorTextGrey,
                        textSize: 12,
                      ),
                    ),
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = items[index];

            var isSelected = index == value;

            return ListTile(
              dense: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              title: TextViewWidget(
                text: data,
                textSize: 14,
                color: isSelected
                    ? colorTextRed
                    : value == -1
                        ? colorTextGrey
                        : null,
              ),
              trailing:
                  !isSelected ? null : const Icon(Icons.check, color: colorRed),
              onTap: () => onSelected(index),
            );
          },
        ),
        if (footer != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: TextViewWidget(
              text: footer!,
              color: colorTextGrey,
              textSize: 12,
            ),
          ),
      ],
    );
  }
}
