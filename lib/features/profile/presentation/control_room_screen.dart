import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/main/main_screen.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ControlRoomScreen extends StatelessWidget {
  const ControlRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPro = false;

    return MainScreen(
      child: Stack(
        children: [
          Container(
            height: .5.sh,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.control.path),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(.2),
                    Colors.black,
                  ],
                  stops: const [0, .1, .6],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                      children: [
                        const TextViewWidget(
                          text: 'SET THE\nCONTROL',
                          textSize: 30,
                          height: 1,
                        ),
                        const SizedBox(height: 14),
                        const TextViewWidget(
                          text:
                              'Your control room where you can consult all the\nperformances, manage your Gated Contents,\nbuy PowerTokens and more.',
                          textSize: 12,
                        ),
                        const SizedBox(height: 40),
                        const ControlItem(title: 'INSIGHTS'),
                        const SizedBox(height: 2),
                        ControlItem(
                          isPro: !isPro,
                          title: 'SERVICE OFFERING',
                        ),
                        const SizedBox(height: 2),
                        ControlItem(
                          isPro: !isPro,
                          title: 'YOUR BAND(S)/COLLECTIVE(S)',
                          // location: const PowerTokenRoute().location,
                        ),
                        const SizedBox(height: 2),
                        const ControlItem(
                          title: 'YOUR CONTRACTS & COLLABS',
                          // location: const PowerTokenRoute().location,
                        ),
                        const SizedBox(height: 2),
                        ControlItem(
                          isPro: !isPro,
                          title: 'MEMBERSHIPS',
                          // location: const MembershipRoute().location,
                        ),
                        const SizedBox(height: 2),
                        ControlItem(
                          title: 'MANAGE CAMPAIGNS',
                          // location: const ManageCampaignRoute().location,
                        ),
                        const SizedBox(height: 2),
                        ControlItem(
                          title: 'MANAGE MY EVENTS',
                          location: const ManageEventRoute().location,
                        ),
                        const SizedBox(height: 2),
                        ControlItem(
                          title: 'SAVED SEARCHES',
                          // location: const SavedSearchRoute().location,
                        ),
                        const SizedBox(height: 2),
                        ControlItem(
                          title: 'DRAFTS',
                          location: const DraftRoute().location,
                        ),
                        const SizedBox(height: 2),
                        ControlItem(
                          title: 'GIGLIST',
                          location: const ManageGiglistRoute().location,
                        ),
                        // const SizedBox(height: 2),
                        // ControlItem(
                        //   title: 'FAVORITES GIGLIST',
                        //   location: const GiglistFavRoute().location,
                        // ),
                        // ControlItem(
                        //   title: 'GIGGER POWERTOKENS',
                        //   location: const PowerTokenRoute().location,
                        // ),
                        // const SizedBox(height: 2),
                        // const ControlItem(title: 'SMART CONTRACTS'),
                        // const SizedBox(height: 2),
                        // const SizedBox(height: 2),
                        // const SizedBox(height: 2),
                        // const SizedBox(height: 2),
                        // const SizedBox(height: 2),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ControlItem extends StatelessWidget {
  const ControlItem({
    super.key,
    required this.title,
    this.location,
    this.isPro = false,
  });

  final String title;
  final String? location;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () {
        if (location != null) context.push(location!);
      },
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          TextViewWidget(
            text: title,
            textSize: 14.sp,
            color: isPro ? colorGrey : null,
          ),
          if (isPro)
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: TextViewWidget(
                text: 'PRO',
                textSize: 12.sp,
                color: colorRed,
              ),
            ),
        ],
      ),
      trailing: const Icon(
        CupertinoIcons.right_chevron,
        color: colorWhite,
      ),
    );
  }
}
