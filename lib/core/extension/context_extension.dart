import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void clearFocus() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}
