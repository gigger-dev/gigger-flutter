import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class SplashBg extends StatelessWidget {
  const SplashBg({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            colorBlack1A.withOpacity(1),
            BlendMode.hardLight,
          ),
          image: AssetImage(Assets.images.giMiniaturaVideo6.path),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
