import 'package:flutter/material.dart';

import 'package:mobile_gigger_app/core/utils/size_utils.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/category_tab_widget.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class LookingForWidget extends StatelessWidget {
  const LookingForWidget({
    super.key,
    required this.isLookingFor,
    required this.onChanged,
  });

  final bool isLookingFor;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextViewWidget(
          text: 'Type of announcement',
          textSize: SizeUtils.textSizeExtraSmall,
        ),
        const TextViewWidget(
          text: 'Let us know if you are:',
          textSize: SizeUtils.textSizeExtraSmall,
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              TabItem(
                title: 'Looking for',
                isSelected: isLookingFor,
                onTap: () => onChanged(true),
              ),
              SizedBox(width: 12),
              TabItem(
                title: 'Offering',
                isSelected: !isLookingFor,
                onTap: () => onChanged(false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
