import 'package:flutter/cupertino.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CircleRowItem extends StatelessWidget {
  const CircleRowItem(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorRed),
            ),
          ),
          const SizedBox(width: 8),
          TextViewWidget(text: text),
        ],
      ),
    );
  }
}
