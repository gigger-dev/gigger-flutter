import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class AuthBg extends StatelessWidget {
  const AuthBg({
    super.key,
    required this.child,
    this.padding,
    this.colorFilter = true,
  });

  final Widget child;
  final bool colorFilter;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(Assets.images.giMiniaturaVideo6.path),
          colorFilter: !colorFilter
              ? null
              : ColorFilter.mode(
                  colorBlack.withOpacity(.86),
                  BlendMode.hardLight,
                ),
        ),
      ),
      child: child,
    );
  }
}
