import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class TextBoxWidget extends StatelessWidget {
  const TextBoxWidget({super.key, this.hintText});

  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 12, color: colorWhite),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorWhite),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorWhite),
        ),
      ),
    );
  }
}
