import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/login_widgets/username_widget.dart';

class EmailFormWidget extends StatelessWidget {
  const EmailFormWidget(this.controller, {super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return UserNameWidget(
      controller: controller,
      onChanged: () {},
    );
  }
}
