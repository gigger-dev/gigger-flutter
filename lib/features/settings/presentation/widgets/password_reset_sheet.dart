import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_box_widget.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class PasswordResetSheet extends StatefulWidget {
  const PasswordResetSheet({super.key});

  @override
  State<PasswordResetSheet> createState() => _PasswordResetSheetState();
}

class _PasswordResetSheetState extends State<PasswordResetSheet> {
  final controller = PageController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: colorBlack),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: context.pop,
            icon: const Icon(Icons.clear, color: colorWhite, size: 30),
          ),
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (value) {
                current = value;
                setState(() {});
              },
              children: const [
                Column(
                  children: [
                    SizedBox(height: 30),
                    Center(
                      child: Text.rich(TextSpan(
                        style: TextStyle(fontSize: 15, color: colorWhite),
                        children: [
                          TextSpan(text: 'It\'s okay, '),
                          TextSpan(
                              text: 'reset', style: TextStyle(color: colorRed)),
                          TextSpan(text: ' your password!'),
                        ],
                      )),
                    ),
                    SizedBox(height: 60),
                    TextBoxWidget(hintText: 'Enter your email'),
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 15, color: colorWhite),
                          children: [
                            TextSpan(text: 'We have sent a '),
                            TextSpan(
                                text: 'code',
                                style: TextStyle(color: colorRed)),
                            TextSpan(text: ' on your\nemail or phone number'),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 60),
                    TextBoxWidget(hintText: 'Insert code ...'),
                    SizedBox(height: 20),
                    TextBoxWidget(hintText: 'New password ...'),
                    SizedBox(height: 20),
                    TextBoxWidget(hintText: 'Confirm new password ...'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextViewWidget(text: 'Done!', color: colorRed),
                    SizedBox(height: 20),
                    TextViewWidget(
                      text:
                          'Please login with the new password!\nWe sent a Confirm to your email address',
                      textAlign: TextAlign.center,
                      textSize: 13,
                    ),
                  ],
                )
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              if (current == 2) {
                context.pop();
                LoginRoute().replace(context);
                return;
              }

              controller.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: colorWhite),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: Center(
              child: TextViewWidget(
                text: current == 2
                    ? 'Login with new password'
                    : current == 1
                        ? 'Change password'
                        : 'Continue',
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
