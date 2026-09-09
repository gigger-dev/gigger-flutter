import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/widgets/circle_row_item.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CancelConfirmDialog extends StatelessWidget {
  const CancelConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextViewWidget(
                text: 'YOU ARE LEAVING THE\nEDITOR BUT YOU CAN\'T',
                textSize: 24,
                height: 1.2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              TextViewWidget(
                text: 'Please complete your profile',
                textSize: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 80),
        const CircleRowItem('Cover image, GIF or 5 secs video loop'),
        const SizedBox(height: 4),
        const CircleRowItem('Avatar image'),
        const SizedBox(height: 4),
        const CircleRowItem('Basic profile info'),
        const SizedBox(height: 4),
        const CircleRowItem('At least one media in the FAB9 Gallery'),
        const SizedBox(height: 4),
        const CircleRowItem('Custom phrase & Closing message'),
        const SizedBox(height: 70),
        // OutlinedBtn(
        //   onPressed: () => context.pop(),
        //   text: 'Okiedokie, I do it..',
        // ),
        // const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.all(20),
          child: GradientFilledButton(
            title: 'Continue editing',
            onPressed: context.pop,
          ),
        )
      ],
    );
  }
}
