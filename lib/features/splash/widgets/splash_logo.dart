import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform.scale(
          scale: 0.5,
          child: SizedBox(
            child: Image.asset(Assets.images.giGroup.path),
          ),
        ),
        TextViewWidget(
          text: 'Music. Connected. \n EveryWhere.',
          textAlign: TextAlign.center,
          textSize: 14.sp,
          color: colorWhite,
        ),
      ],
    );
  }
}
