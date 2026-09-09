import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class AdsArchiveScreen extends StatefulWidget {
  const AdsArchiveScreen({super.key});

  @override
  State<AdsArchiveScreen> createState() => _AdsArchiveScreenState();
}

class _AdsArchiveScreenState extends State<AdsArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: colorWhite),
        title: const TextViewWidget(text: 'Your ads archive', textSize: 16),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: TextViewWidget(text: 'ADS ARCHIVE'),
          ),
          GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorBlack1A,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.topRight,
                      child: PopupMenuButton(
                        color: colorRed,
                        onSelected: (value) {
                          if (value == 3) {
                            showDeleteSheet();
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            child: TextViewWidget(text: 'Insights'),
                          ),
                          const PopupMenuItem(
                            child: TextViewWidget(text: 'Modify'),
                          ),
                          const PopupMenuItem(
                            child: TextViewWidget(text: 'Boost again!'),
                          ),
                          const PopupMenuItem(
                            value: 3,
                            child: TextViewWidget(text: 'Delete it'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextViewWidget(text: 'Best Guitars on SALE'),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16),
                            SizedBox(width: 4),
                            TextViewWidget(
                                text: 'Caltanisetta, Ita', textSize: 12)
                          ],
                        ),
                        SizedBox(height: 4),
                        TextViewWidget(
                          text: 'SUPER SALES! Visit now our off ...',
                          height: 1,
                          textSize: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void showDeleteSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        // color: colorBlack,
        color: Colors.grey.shade900,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextViewWidget(
              text: 'DELETE THIS AD?',
              textSize: 26,
            ),
            const SizedBox(height: 20),
            const TextViewWidget(
              text:
                  'You will lose forever your advertisement.\nPlease confirm or return to archive.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            OutlinedBtn(
              onPressed: () {}, text: 'Yes, delete this AD',
              // style: OutlinedButton.styleFrom(
              //   padding: const EdgeInsets.symmetric(vertical: 14),
              // ),
              // child: const Center(
              //   child: TextViewWidget(text: 'Yes, delete this AD'),
              // ),
            ),
            const SizedBox(height: 10),
            GradientFilledButton(
              title: 'Back to ADS archive',
              textSize: 14,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
