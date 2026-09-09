import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class SettingDivider extends StatelessWidget {
  const SettingDivider({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 10,
      endIndent: 10,
      height: height,
      color: colorWhite,
    );
  }
}
