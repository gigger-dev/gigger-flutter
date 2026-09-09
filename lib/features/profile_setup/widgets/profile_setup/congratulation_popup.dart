import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/text_style.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';

class CongratulationPopup extends StatelessWidget {
  const CongratulationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'CONGRATULATIONS!',
            style: popupTitleStyle,
            textAlign: TextAlign.center,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              'Post at least one content right away, to make it easier to find your profile, your content and improve your experience on Gigger!',
              style: popupDescStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: .04.sh),
          OutlinedBtn(
            onPressed: context.pop,
            text: 'No, do it later',
          ),
          // const SizedBox(height: 4),
          // GradientFilledButton(
          //   title: 'Open editor & post now',
          //   onPressed: () {},
          // )
        ],
      ),
    );
  }
}
