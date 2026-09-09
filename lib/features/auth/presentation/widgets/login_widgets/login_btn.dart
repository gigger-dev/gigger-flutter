import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/widgets/loading_button.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({super.key, required this.isLoading, required this.onTap});

  final bool isLoading;
  final AsyncCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LoadingButton(
      title: 'Start me up!',
      isLoading: isLoading,
      boxShadow: const BoxShadow(
        color: Color.fromRGBO(52, 21, 0, 0.75),
        offset: Offset(45, 45),
        blurRadius: 37.5,
        spreadRadius: 0.0,
      ),
      onPressed: onTap,
    );
  }
}
