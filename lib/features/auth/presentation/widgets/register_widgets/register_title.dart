import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle(this.fromSheet, {super.key});

  final bool fromSheet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextViewWidget(
          text: fromSheet ? 'CREATE\nNEW ACCOUNT' : 'SIGN UP',
          textSize: 31.sp,
          height: 1,
        ),
        SizedBox(height: 5.h),
        TextViewWidget(
          text: fromSheet
              ? 'New accounts will be available with a double tap on the profile icon or from the main menu'
              : 'Be part of the Disruptive Music Movement!',
          textSize: 13.sp,
        ),
      ],
    );
  }
}
