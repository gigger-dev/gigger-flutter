import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class InterestTitle extends StatelessWidget {
  const InterestTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 18),
          child: const TextViewWidget(
            text: 'SELECT YOUR \nINTERESTS',
            textSize: 36,
            color: colorWhite,
            letterSpacing: 1.5,
            height: 1,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 18),
          child: const TextViewWidget(
            text: 'Help us improve your experience',
            textSize: 16,
            color: colorWhite,
          ),
        ),
      ],
    );
  }
}
