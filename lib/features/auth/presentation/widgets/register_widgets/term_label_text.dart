import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class TermLabelText extends StatelessWidget {
  const TermLabelText({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextViewWidget(
            text: 'By creating your account, you agree to',
            color: colorWhite,
          ),
          SizedBox(width: 5.w),
          const TextViewWidget(
            text: 'Gigger terms of use',
            shadows: [
              Shadow(
                color: colorTransparent,
                offset: Offset(0, -1),
              )
            ],
            color: colorRed,
            decorationThickness: 1,
            decorationColor: colorRed,
            textDecoration: TextDecoration.underline,
          ),
        ],
      ),
    );
  }
}
