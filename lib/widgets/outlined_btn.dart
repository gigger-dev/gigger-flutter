import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class OutlinedBtn extends StatelessWidget {
  const OutlinedBtn({super.key, this.onPressed, required this.text});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: colorWhite),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Center(
        child: TextViewWidget(text: text, textSize: 16),
      ),
    );
  }
}
