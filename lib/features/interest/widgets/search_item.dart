import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.onTap, required this.data});

  final InterestOut data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0, 50),
          end: Alignment(100, 50),
          colors: [colorBtnOrangeRed, colorOrangeRed],
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: colorBlack.withOpacity(.4),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(10, 10),
          )
        ],
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 1.0, color: colorTransparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextViewWidget(text: data.name, textSize: 12.sp),
            const SizedBox(width: 10),
            const Icon(Icons.clear, color: colorWhite, size: 20),
          ],
        ),
      ),
    );
  }
}
