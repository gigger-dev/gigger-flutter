import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/password_reset_sheet.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_box_widget.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class EmailPasswordScreen extends StatefulWidget {
  const EmailPasswordScreen({super.key});

  @override
  State<EmailPasswordScreen> createState() => _EmailPasswordScreenState();
}

class _EmailPasswordScreenState extends State<EmailPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Email and Password',
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 10),
        const TextBoxWidget(
          hintText: 'Current email',
        ),
        const SizedBox(height: 30),
        const TextBoxWidget(
          hintText: 'New email ...',
        ),
        const SizedBox(height: 30),
        const TextBoxWidget(
          hintText: 'Current password ...',
        ),
        const SizedBox(height: 30),
        const TextBoxWidget(
          hintText: 'New password ...',
        ),
        const SizedBox(height: 30),
        const TextBoxWidget(
          hintText: 'Confirm new password ...',
        ),
        const SizedBox(height: 30),
        Center(
          child: Column(
            children: [
              const TextViewWidget(text: 'Forgot your password?'),
              const SizedBox(height: 20),
              TextButton(
                onPressed: onResetTap,
                child: const TextViewWidget(text: 'Reset it!', color: colorRed),
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: const TextViewWidget(text: 'Cancel'),
            ),
            SizedBox(
              width: 140,
              child: GradientFilledButton(
                title: 'Save',
                textSize: 16,
                onPressed: () {},
              ),
            )
          ],
        ),
      ],
    );
  }

  void onResetTap() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const PasswordResetSheet(),
    );
  }
}
