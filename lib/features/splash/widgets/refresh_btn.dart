import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class RefreshBtn extends StatelessWidget {
  const RefreshBtn({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextViewWidget(
          text: 'Connection timeout! Please try again.',
          color: colorRed,
        ),
        const SizedBox(height: 10),
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: colorRed,
            shape: const CircleBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 50),
          ),
          onPressed: onTap,
          icon: const Icon(Icons.refresh, color: colorWhite),
        ),
      ],
    );
  }
}
