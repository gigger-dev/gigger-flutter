import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ConfirmSheet extends StatelessWidget {
  const ConfirmSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextViewWidget(
            text:
                'DRAFT SAVED SUCCESSFULLY!\nYOU\'LL FIND IT IN YOUR\nCONTROL ROOM',
            textSize: 20,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          OutlinedBtn(
            onPressed: () => context.pop(true),
            text: 'Exit the editor',
          ),
          const SizedBox(height: 4),
          GradientFilledButton(
            title: 'Continue to edit',
            onPressed: () => context.pop(false),
          ),
        ],
      ),
    );
  }
}
