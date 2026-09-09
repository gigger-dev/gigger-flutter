import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:mobile_gigger_app/widgets/text_box_widget.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ReportProblemDetailScreen extends StatelessWidget {
  const ReportProblemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Report a problem',
      children: [
        const TextViewWidget(
          text: 'Please describe the problem (90 characters)',
        ),
        const SizedBox(height: 20),
        const TextBoxWidget(
          hintText: 'Write your message here',
        ),
        const SizedBox(height: 40),
        const TextViewWidget(
          text:
              'Add a link (share icon on content > copy link) if it can be useful for reporting',
          textSize: 14,
        ),
        const SizedBox(height: 20),
        const TextBoxWidget(
          hintText: 'Write your message here',
        ),
        const SizedBox(height: 90),
        const Icon(
          CupertinoIcons.square_arrow_up,
          size: 90,
          color: Colors.grey,
        ),
        const SizedBox(height: 10),
        const TextViewWidget(
          text:
              'Upload an image or screenshot to help\nus understand the problem',
          textAlign: TextAlign.center,
          textSize: 14,
          height: 1.2,
        ),
        const SizedBox(height: 50),
        const TextViewWidget(
          text:
              'Please only send us reports regarding\nthe operation of this app. Thank You',
          textAlign: TextAlign.center,
          color: Colors.grey,
          textSize: 12,
        ),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              OutlinedBtn(
                onPressed: () {},
                text: 'Back to Settings',
                // style: OutlinedButton.styleFrom(
                //   padding: const EdgeInsets.symmetric(vertical: 16),
                // ),
                // child: const Center(
                //   child: TextViewWidget(text: 'Back to Settings'),
                // ),
              ),
              const SizedBox(height: 10),
              GradientFilledButton(
                title: 'Report a problem',
                onPressed: () {},
              )
            ],
          ),
        )
      ],
    );
  }
}
