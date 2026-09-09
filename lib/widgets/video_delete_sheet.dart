import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/text_style.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';

class DeleteSheet extends StatelessWidget {
  const DeleteSheet({
    super.key,
    required this.onDelete,
    this.confirmText = 'Yes delete my post',
    this.title = 'YOU ARE DELETING THIS POST, ARE YOU SURE?',
  });

  final VoidCallback onDelete;
  final String title;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Text(
              title,
              style: popupTitleStyle,
              textAlign: TextAlign.center,
            ),
          ),
          OutlinedBtn(onPressed: onDelete, text: confirmText),
          SizedBox(height: 10),
          GradientFilledButton(
            title: 'No, go back',
            onPressed: () => context.pop(),
          )
        ],
      ),
    );
  }
}
