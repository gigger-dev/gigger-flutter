import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class GradientFilledButton extends StatelessWidget {
  const GradientFilledButton({
    super.key,
    required this.title,
    this.onPressed,
    this.padding,
    this.centerText = true,
    this.boxShadow,
    this.textSize,
    this.fontWeight,
  });

  final String title;
  final double? textSize;
  final FontWeight? fontWeight;
  final bool centerText;
  final VoidCallback? onPressed;
  final BoxShadow? boxShadow;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    var isDisabled = onPressed == null;

    Widget child = TextViewWidget(
      text: title,
      textSize: textSize ?? 16,
      color: isDisabled ? colorGrey : null,
      fontWeight: fontWeight ?? FontWeight.normal,
    );

    if (centerText) child = Center(child: child);

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundBuilder: (context, states, child) {
          return Container(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: !isDisabled ? null : Border.all(color: colorGrey),
              boxShadow: boxShadow == null || isDisabled ? null : [boxShadow!],
              gradient: isDisabled
                  ? null
                  : const LinearGradient(
                      colors: [colorRed, colorOrangeRed],
                    ),
            ),
            child: child,
          );
        },
      ),
      child: child,
    );
  }
}
