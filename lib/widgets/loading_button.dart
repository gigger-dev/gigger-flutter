import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.title,
    required this.isLoading,
    required this.onPressed,
    this.loadingMsg,
    this.boxShadow,
  });

  final String title;
  final bool isLoading;
  final String? loadingMsg;
  final BoxShadow? boxShadow;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GradientFilledButton(
      boxShadow: boxShadow,
      onPressed: isLoading ? null : onPressed,
      title: isLoading ? loadingMsg ?? 'Loading...' : title,
    );
  }
}
