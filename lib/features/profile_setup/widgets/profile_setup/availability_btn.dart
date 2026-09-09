import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class AvailabilityBtn extends StatelessWidget {
  const AvailabilityBtn({
    super.key,
    required this.onTap,
    required this.isLast,
    required this.isAvailability,
    required this.status,
  });

  final bool isLast;
  final VoidCallback onTap;
  final bool isAvailability;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isAvailability || isLast ? 1 : .2,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 8,
              backgroundColor: status ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 10),
            TextViewWidget(text: status ? 'Available!' : 'Unavailable!'),
            const SizedBox(width: 10),
            TextViewWidget(
              text: isAvailability ? 'Edit' : 'When?',
              color: colorRed,
              textSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
