import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/size_utils.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CategoryTabWidget extends StatelessWidget {
  const CategoryTabWidget({
    super.key,
    required this.onSelected,
    required this.type,
  });

  final ContentType type;
  final ValueChanged<ContentType> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextViewWidget(
          text: 'Where do you want to create?',
          textSize: SizeUtils.textSizeExtraSmall,
        ),
        const TextViewWidget(
          text: 'Select a category',
          textSize: SizeUtils.textSizeExtraSmall,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ContentType.values.map((e) {
            return TabItem(
              title: e.value,
              isSelected: type == e,
              onTap: () => onSelected(e),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? colorRed : null,
          border: isSelected ? null : Border.all(color: colorWhite),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: TextViewWidget(text: title, textSize: 14),
      ),
    );
  }
}
