import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SignInLabelBtn extends ConsumerWidget {
  const SignInLabelBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextViewWidget(
          text: 'Have already an account?',
          color: colorWhite,
          textSize: 13.sp,
        ),
        SizedBox(width: 5.w),
        InkWell(
          onTap: () {
            ref.read(authControllerProvider.notifier).redirectToLogin();
            LoginRoute().replace(context);
          },
          child: TextViewWidget(
            text: 'SIGN IN',
            textSize: 13.sp,
            color: colorRed,
            decorationThickness: 1,
            decorationColor: colorRed,
            textDecoration: TextDecoration.underline,
          ),
        )
      ],
    );
  }
}
