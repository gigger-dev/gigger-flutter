import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: 1.sh,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            colorFilter: ColorFilter.mode(
                colorBlack.withOpacity(.85), BlendMode.hardLight),
            image: AssetImage(Assets.images.giMiniaturaVideo6.path),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: .05.sh),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Assets.images.giRedGigger.path,
                    width: 70.w,
                  ),
                  Image.asset(
                    Assets.images.giMenu.path,
                    fit: BoxFit.cover,
                    color: colorWhite,
                    width: 18,
                  )
                ],
              ),
            ),
            SizedBox(height: .08.sh),
            const TextViewWidget(
              text:
                  'DISCOVER\nGIGGER\'S FULL\nPOTENTIAL,\nUPGRADE TO A\nPRO ACCOUNT!',
              textAlign: TextAlign.center,
              textSize: 30,
              height: 1,
            ),
            SizedBox(height: .08.sh),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextViewWidget(
                  text: '1 MONTH ',
                  textSize: 20,
                ),
                TextViewWidget(
                  text: 'FREE TRIAL',
                  textSize: 20,
                  color: colorTextRed,
                ),
              ],
            ),
            const TextViewWidget(
              text: 'THEN ONLY 39€ / Year',
              textSize: 20,
            ),
            const SizedBox(height: 10),
            const TextViewWidget(
              text: 'Try Gigger Pro and get a special discount!',
              textSize: 12,
            ),
            SizedBox(height: .1.sh),
            const TextViewWidget(
              text:
                  'Everyone by subscribing Gigger\ngets a Free Account\nYou can always upgrade to Pro later\nto empower your experience',
              textSize: 13,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: context.pop,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Center(
                      child: TextViewWidget(
                        text: 'Back to Settings',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      SheetUtils.newComingSoonSheet(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundBuilder: (context, states, child) {
                        return Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [colorRed, colorOrangeRed],
                            ),
                          ),
                          child: child,
                        );
                      },
                    ),
                    child: const Center(
                      child: TextViewWidget(
                        text: 'Tell me about the Pro month trial',
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const TextViewWidget(
                    text: 'Awesome image by Bryan Catota: Thank you!',
                    color: colorTextGrey,
                    textSize: 10,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
