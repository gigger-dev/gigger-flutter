import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/utils/size_utils.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/category_tab_widget.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class PerformerWidget extends StatelessWidget {
  const PerformerWidget({
    super.key,
    required this.isPerformer,
    required this.onChanged,
  });

  final bool isPerformer;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextViewWidget(
          text: 'Choose the category',
          textSize: SizeUtils.textSizeExtraSmall,
        ),
        const TextViewWidget(
          text: 'Let Giggers easily find your classified',
          textSize: SizeUtils.textSizeExtraSmall,
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              TabItem(
                title: 'Performer',
                isSelected: isPerformer,
                onTap: () => onChanged(true),
              ),
              SizedBox(width: 12),
              TabItem(
                title: 'Gear',
                isSelected: !isPerformer,
                onTap: () => onChanged(false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
