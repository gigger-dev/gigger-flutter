import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/consts/text_style.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';

class SubmitPopup extends StatelessWidget {
  const SubmitPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
      decoration: BoxDecoration(
        color: colorBlack1A,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ALMOST DONE! NOW LET\'S CHECK AND FULLFILL YOUR PROFILE!',
            style: popupTitleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          const Text(
            'Follow the wizard and complete your profile. The better your profile, the easier it will be for users to connect with you.',
            textAlign: TextAlign.center,
            style: popupDescStyle,
          ),
          const SizedBox(height: 40),
          GradientFilledButton(
            title: 'Ok, let\'s do it!',
            fontWeight: FontWeight.normal,
            onPressed: () => context.pop(true),
          )
        ],
      ),
    );
  }
}
