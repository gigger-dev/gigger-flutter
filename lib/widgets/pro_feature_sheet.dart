import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ProFeatureSheet extends StatelessWidget {
  const ProFeatureSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.clear, color: colorWhite, size: 30),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextViewWidget(
                text: 'THIS IS A GIGGER\'S\nPRO FEATURE!',
                height: 1,
                textSize: 30,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: 100,
                  child: Divider(color: colorWhite),
                ),
              ),
              TextViewWidget(
                text: 'PLEASE CHECK OUR\nPRICING PLANS',
                height: 1,
                textSize: 22,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              OutlinedBtn(
                onPressed: () => context.pop(),
                text: 'No, use the free version',
              ),
              const SizedBox(height: 10),
              GradientFilledButton(
                title: 'Yeah! Upgrade to PRO',
                boxShadow: BoxShadow(
                  color: colorBlack.withOpacity(.6),
                  offset: const Offset(6, 10),
                  blurRadius: 10,
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              // ListTile(
              //   title: Center(
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Checkbox(
              //           value: false,
              //           side: const BorderSide(color: colorWhite),
              //           onChanged: (value) {},
              //         ),
              //         const TextViewWidget(
              //           text: 'Don\'t show this anymore',
              //           textSize: 12,
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
