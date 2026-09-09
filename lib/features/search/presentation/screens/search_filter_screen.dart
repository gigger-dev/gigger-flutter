import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/all_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/artist_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/campaign_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/event_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/giglist_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/membership_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/service_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/video_filter_widget.dart';

class SearchFilterScreen extends StatefulWidget {
  const SearchFilterScreen({super.key, this.index = 0});

  final int index;

  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      initialIndex: widget.index,
      child: Scaffold(
        backgroundColor: colorBlack,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const Positioned.fill(
              child: TabBarView(
                physics: PageScrollPhysics(),
                children: [
                  AllFilterWidget(),
                  ArtistFilterWidget(),
                  VideoFilterWidget(),
                  EventFilterWidget(),
                  ServiceFilterWidget(),
                  CampaignFilterWidget(),
                  MembershipFilterWidget(),
                  GiglistFilterWidget(),
                ],
              ),
            ),
            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: Container(
                height: .14.sh,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      colorTransparent,
                      Color.fromRGBO(0, 0, 0, 0.93),
                      colorBlack,
                    ],
                    stops: [0, 0.75, 1],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: colorTransparent,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  color: colorWhite,
                  onPressed: () => context.pop(),
                  icon: const Icon(CupertinoIcons.left_chevron),
                ),
                title: TabBar(
                  isScrollable: true,
                  indicatorWeight: 0,
                  indicatorColor: colorTextRed,
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  labelStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: colorTextRed,
                    fontSize: 14.sp,
                  ),
                  labelColor: colorTextRed,
                  unselectedLabelColor: Colors.white,
                  splashBorderRadius: BorderRadius.circular(20),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.zero,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  tabs: const [
                    Tab(text: 'ALL'),
                    Tab(text: 'GIGGERS'),
                    Tab(text: 'VIDEOS'),
                    Tab(text: 'EVENTS'),
                    Tab(text: 'SERVICES'),
                    Tab(text: 'CAMPAIGNS'),
                    Tab(text: 'MEMBERSHIPS'),
                    Tab(text: 'GIGLIST'),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    color: colorWhite,
                    icon: const Icon(Icons.more_horiz),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
