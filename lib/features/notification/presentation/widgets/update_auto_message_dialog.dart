import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class UpdateAutoMessageDialog extends StatelessWidget {
  const UpdateAutoMessageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colorBlack1A,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextViewWidget(text: 'Set Auto Message'),
          const SizedBox(height: 16),
          TextFormField(
            style: const TextStyle(fontSize: 12, color: colorWhite),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              hintText: 'Thank You',
              hintStyle: TextStyle(fontSize: 12, color: colorTextGrey),
            ),
          ),
          const SizedBox(height: 20),
          GradientFilledButton(
            title: 'Save',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
