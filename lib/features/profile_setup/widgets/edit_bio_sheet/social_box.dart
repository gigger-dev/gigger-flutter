import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class SocialBox extends StatelessWidget {
  const SocialBox({
    super.key,
    required this.icon,
    this.isBorder = false,
    this.focus,
    this.focusIcon,
    this.padding = 6,
    this.focusColor,
    required this.controller,
  });

  final FocusNode? focus;
  final AssetGenImage icon;
  final AssetGenImage? focusIcon;
  final bool isBorder;
  final double padding;
  final Color? focusColor;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var color = focus?.hasFocus ?? false ? colorRed : null;

    return Row(
      children: [
        Container(
          height: 34,
          width: 34,
          decoration: !isBorder
              ? null
              : BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: color ?? Colors.grey),
                ),
          padding: !isBorder ? null : EdgeInsets.all(padding),
          child: Image.asset(
            focus?.hasFocus ?? false ? (focusIcon ?? icon).path : icon.path,
            color: focus?.hasFocus ?? false ? focusColor : Colors.grey,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            focusNode: focus,
            controller: controller,
            onTapOutside: (_) => context.clearFocus(),
            onFieldSubmitted: (_) => context.clearFocus(),
            style: const TextStyle(fontSize: 13, color: colorWhite),
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Enter link',
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
          ),
        ),
      ],
    );
  }
}
