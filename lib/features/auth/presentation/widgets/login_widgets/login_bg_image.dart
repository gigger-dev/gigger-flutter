import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class LoginBgImage extends StatelessWidget {
  const LoginBgImage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(15.69, 102.54),
          end: Alignment(84.31, -2.54),
          colors: [
            colorOrangeRed,
            colorBtnOrangeRed,
          ],
        ),
        image: DecorationImage(
          image: AssetImage(Assets.images.giGiggerLogin.path),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}
