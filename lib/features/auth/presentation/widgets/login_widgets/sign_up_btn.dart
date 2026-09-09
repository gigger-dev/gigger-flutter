import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SignUpBtn extends StatelessWidget {
  const SignUpBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextViewWidget(
          text: "Don't have an account?",
          color: colorWhite,
          textSize: 13.sp,
        ),
        SizedBox(width: 2.w),
        InkWell(
          onTap: () {
            context.clearFocus();
            const RegisterRoute().replace(context);
          },
          child: TextViewWidget(
            text: 'SIGN UP',
            shadows: const [
              Shadow(color: colorTransparent, offset: Offset(0, -1))
            ],
            textSize: 13.sp,
            color: colorWhite,
            decorationColor: colorWhite,
            decorationThickness: 1,
            textDecoration: TextDecoration.underline,
          ),
        )
      ],
    );
  }
}
