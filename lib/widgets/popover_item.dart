import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class PopoverItem extends StatelessWidget {
  const PopoverItem({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
        onTap();
      },
      borderRadius: BorderRadius.circular(7),
      child: Container(
        height: 40,
        color: colorTransparent,
        child: Center(
          child: TextViewWidget(text: title, textSize: 13.sp),
        ),
      ),
    );
  }
}
