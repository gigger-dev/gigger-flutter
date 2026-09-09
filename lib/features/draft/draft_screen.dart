import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/draft/widgets/campaign_draft.dart';
import 'package:mobile_gigger_app/features/draft/widgets/event_draft.dart';
import 'package:mobile_gigger_app/features/draft/widgets/giglist_draft.dart';
import 'package:mobile_gigger_app/features/draft/widgets/membership_draft.dart';
import 'package:mobile_gigger_app/features/draft/widgets/post_draft.dart';
import 'package:mobile_gigger_app/features/draft/widgets/sup_draft.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorBlack,
        title: const TextViewWidget(text: 'Drafts'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextViewWidget(
                  text: 'YOUR\nDRAFTS',
                  textSize: 32.sp,
                  height: 1,
                ),
                SizedBox(height: 10),
                TextViewWidget(
                  text: 'Save your drafts here!\n'
                      'You can also activate notifications\n'
                      'for new similar content!',
                  height: 1.3,
                  textSize: 12.sp,
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          PostDraft(),
          SizedBox(height: 10),
          GiglistDraft(),
          SizedBox(height: 10),
          SupDraft(),
          SizedBox(height: 10),
          EventDraft(),
          SizedBox(height: 10),
          Opacity(opacity: .5, child: MembershipDraft()),
          SizedBox(height: 10),
          Opacity(opacity: .5, child: CampaignDraft())
        ],
      ),
    );
  }
}
