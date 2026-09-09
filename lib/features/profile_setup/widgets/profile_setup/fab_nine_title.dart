import 'package:flutter/cupertino.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class FabNineTitle extends StatelessWidget {
  const FabNineTitle({super.key, required this.isLast});

  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isLast ? 1 : .2,
      child: Row(
        children: [
          TextViewWidget(text: 'FAB NINE', textSize: 14),
          SizedBox(width: 10),
          Expanded(
            child: FittedBox(
              child: TextViewWidget(
                text: 'Tap + and add your best media here',
                color: colorGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
