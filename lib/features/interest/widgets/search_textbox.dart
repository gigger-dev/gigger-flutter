import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class SearchTextBox extends StatefulWidget {
  const SearchTextBox({
    super.key,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
  });

  final bool readOnly;
  final bool autofocus;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  State<SearchTextBox> createState() => _SearchTextBoxState();
}

class _SearchTextBoxState extends State<SearchTextBox> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 12, color: colorWhite),
      decoration: const InputDecoration(
        isDense: true,
        hintText: 'Search ...',
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        hintStyle: TextStyle(color: colorWhite, fontSize: 14),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: colorWhite),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorWhite),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorWhite),
        ),
      ),
    );
  }

  void onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onChanged?.call(value);
    });
  }
}
