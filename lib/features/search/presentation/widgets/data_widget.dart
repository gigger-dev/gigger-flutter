import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class DataWidget extends StatefulWidget {
  const DataWidget({super.key, required this.index});

  final int index;

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller =
        TabController(length: 7, vsync: this, initialIndex: widget.index);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorBlack,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            Assets.images.giRedGigger.path,
            width: 70.w,
          ),
        ),
        leadingWidth: 70,
        title: TabBar(
          controller: controller,
          indicatorColor: colorTextRed,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          isScrollable: true,
          indicatorWeight: 0,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
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
            Tab(text: 'EVENTS'),
            Tab(text: 'SERVICES'),
            Tab(text: 'CAMPAIGNS'),
            Tab(text: 'MEMBERSHIPS'),
            Tab(text: 'GIGLIST'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Assets.images.giMenu.path,
              fit: BoxFit.cover,
              color: colorWhite,
              width: 18,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          // Positioned(
          //   top: 0,
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: TabBarView(
          //     controller: controller,
          //     physics: const NeverScrollableScrollPhysics(),
          //     children: const [
          //       // AllFilterWidget(),
          //       // ArtistVideoWidget(),
          //       // ArtistVideoWidget(),
          //       // EventVideoWidget(),
          //       // ProServiceVideoWidget(),
          //       // CampaignVideoWidget(),
          //       // MembershipVideoWidget(),
          //       // GiglistVideoWidget(),
          //     ],
          //   ),
          // ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: .14.sh,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorTransparent,
                    Color.fromRGBO(0, 0, 0, 0.93),
                    colorBlack
                  ],
                  stops: [0, .3, .5],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: Builder(builder: (context) {
                return TextFormField(
                  readOnly: true,
                  onTap: () => onSearchTap(),
                  style: const TextStyle(fontSize: 12, color: colorWhite),
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 12, color: colorWhite),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorWhite),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorWhite),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  void onSearchTap() {
    SearchFilterRoute(index: controller.index).push(context);
  }
}
