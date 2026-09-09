import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class PrivateBadge extends StatelessWidget {
  const PrivateBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 20),
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: colorRed,
        child: Icon(
          Icons.lock_person_outlined,
          color: colorWhite,
          size: 16,
        ),
      ),
      title: TextViewWidget(
        text: 'This profile is private.',
        textSize: 13.sp,
        fontWeight: FontWeight.w600,
        height: 1,
      ),
      subtitle: TextViewWidget(
        text: 'You can follow it to see it.',
        textSize: 11.sp,
        height: 1,
      ),
    );
  }
}
