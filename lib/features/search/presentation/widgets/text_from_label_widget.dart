import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class TextFormLabelWidget extends StatelessWidget {
  const TextFormLabelWidget({
    super.key,
    required this.label,
    this.hintText,
    this.textsize = 12,
    this.width,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.enabled = true,
  });

  final String label;
  final bool enabled;
  final double? width;
  final bool readOnly;
  final double textsize;
  final String? hintText;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextViewWidget(text: label, textSize: 12)),
        SizedBox(
          width: width ?? 240,
          child: TextFormField(
            onTap: onTap,
            controller: controller,
            readOnly: readOnly || onTap != null,
            style: TextStyle(fontSize: textsize, color: colorWhite),
            decoration: InputDecoration(
              isDense: true,
              enabled: enabled,
              hintText: hintText,
              hintStyle: TextStyle(fontSize: textsize, color: colorTextGrey),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: colorWhite),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: colorWhite),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: colorWhite),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
