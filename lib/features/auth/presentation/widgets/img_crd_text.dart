import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ImgCrdText extends StatelessWidget {
  const ImgCrdText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextViewWidget(
      text: 'Awesome image by Bryan Catota: Thank you!',
      color: colorWhite.withOpacity(0.5),
      textSize: 9.sp,
    );
  }
}
