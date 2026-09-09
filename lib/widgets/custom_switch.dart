import 'package:flutter/cupertino.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .7,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        trackColor: colorGrey,
        activeColor: colorGrey,
        thumbColor: value ? colorRed : null,
      ),
    );
  }
}
