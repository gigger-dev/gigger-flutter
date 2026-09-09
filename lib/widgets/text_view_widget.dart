import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/consts/color.dart';

class TextViewWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final int? maxLines;
  final double? height;
  final double? textSize;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final List<Shadow>? shadows;
  final Color? decorationColor;
  final FontWeight? fontWeight;
  final String? semanticsLabel;
  final TextOverflow? textOverflow;
  final double? decorationThickness;
  final TextDecoration? textDecoration;

  const TextViewWidget({
    super.key,
    this.color,
    this.height,
    this.shadows,
    this.textSize,
    this.maxLines,
    this.textAlign,
    this.fontWeight,
    this.textOverflow,
    required this.text,
    this.letterSpacing,
    this.textDecoration,
    this.semanticsLabel,
    this.decorationColor,
    this.decorationThickness,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      semanticsLabel: semanticsLabel,
      style: TextStyle(
        height: height,
        shadows: shadows,
        fontWeight: fontWeight,
        overflow: textOverflow,
        color: color ?? colorWhite,
        fontSize: textSize ?? 14.sp,
        letterSpacing: letterSpacing,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
        decoration: textDecoration ?? TextDecoration.none,
      ),
    );
  }
}
