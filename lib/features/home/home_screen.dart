import 'dart:async';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/core/helpers/notification_helper.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/artist_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/event_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_giglist_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/selector_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/sup_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/home/widgets/all_widget.dart';
import 'package:mobile_gigger_app/features/home/widgets/artist_widget.dart';
import 'package:mobile_gigger_app/features/home/widgets/campaign_widget.dart';
import 'package:mobile_gigger_app/features/home/widgets/event_widget.dart';
import 'package:mobile_gigger_app/features/home/widgets/giglist_widget.dart';
import 'package:mobile_gigger_app/features/home/widgets/home_top_slider_widget.dart';
import 'package:mobile_gigger_app/features/home/widgets/membership_widget.dart';
import 'package:mobile_gigger_app/features/home/widgets/noti_btn.dart';
import 'package:mobile_gigger_app/features/home/widgets/pro_service_widget.dart';
import 'package:mobile_gigger_app/features/home/widgets/sup_bottom.dart';
import 'package:mobile_gigger_app/features/home/widgets/video_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profiles_controller.dart';
import 'package:mobile_gigger_app/features/search/presentation/screens/search_screen.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/popup_btn.dart';
import 'package:popover/popover.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  bool hideBgImg = false;
  bool hideSup = false;
  bool isVisibleForUser = true;

  late PageController _controller;
  late TabController tabController;
  int current = 1;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    NotificationHelper.initialize();

    tabController =
        TabController(length: 9, vsync: this, initialIndex: current);
    scrollController.addListener(() {
      var pixels = scrollController.position.pixels;
      hideSup = scrollController.position.userScrollDirection ==
          ScrollDirection.reverse;

      isVisibleForUser = pixels < 70.0;
      hideBgImg = pixels > 200.0;

      setState(() {});

      // if (scrollController.position.pixels ==
      //     scrollController.position.maxScrollExtent) {
      //   ref.read(videoControllerProvider.notifier).loadMore();
      // }
    });

    _controller = PageController(initialPage: 1);
    // ..addListener(() {
    //   if (tabController.index != 9) return;

    //   if (_controller.offset > _controller.position.maxScrollExtent) {
    //     _controller.animateToPage(
    //       1,
    //       curve: Curves.ease,
    //       duration: const Duration(milliseconds: 400),
    //     );
    //   }
    // });

    ref.read(profilesControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    var profile =
        ref.watch(profileControllerProvider).whenData((v) => v).valueOrNull;

    if (profile == null) return SizedBox();

    return EasyRefresh(
      triggerAxis: Axis.vertical,
      header: MaterialHeader(),
      onRefresh: onRefresh,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            stops: [0, 1],
            begin: Alignment(0, 50),
            end: Alignment(100, 50),
            colors: [colorBlack, Color(0xff707070)],
          ),
          image: hideBgImg
              ? null
              : DecorationImage(
                  colorFilter: ColorFilter.mode(
                    colorBlack1A.withOpacity(0.4),
                    BlendMode.hardLight,
                  ),
                  image: AssetImage(Assets.images.giAlenaDarmel.path),
                  fit: BoxFit.cover,
                ),
        ),
        child: Stack(
          children: [
            NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  primary: true,
                  toolbarHeight: 50,
                  collapsedHeight: 50,
                  expandedHeight: 360,
                  automaticallyImplyLeading: false,
                  surfaceTintColor: Colors.transparent,
                  flexibleSpace: Container(
                    decoration: !hideBgImg
                        ? null
                        : BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                colorBlack,
                                colorBlack.withOpacity(.4),
                                colorTransparent,
                              ],
                              stops: const [.6, .9, 1],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                    alignment: Alignment.centerLeft,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            alignment: Alignment.centerLeft,
                            child: child,
                          ),
                        );
                      },
                      child: !isVisibleForUser
                          ? const SizedBox(key: ValueKey('null'))
                          : HomeTopSliderWidget(
                              key: ValueKey(profile.uuid),
                              profile: profile,
                            ),
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: colorTransparent,
                  floating: false,
                  bottom: TabBar(
                    indicatorWeight: 0,
                    onTap: (value) {
                      if (value == 0) {
                        // SearchRoute().push(context);
                        context.pushTransparentRoute(SearchScreen());
                        tabController.animateTo(current);
                        return;
                      }

                      _controller.animateToPage(
                        value,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    },
                    isScrollable: true,
                    labelColor: colorTextRed,
                    controller: tabController,
                    indicatorColor: colorTextRed,
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(),
                    unselectedLabelColor: Colors.white,
                    padding: const EdgeInsets.only(left: 20),
                    splashBorderRadius: BorderRadius.circular(20),
                    unselectedLabelStyle: const TextStyle(fontSize: 14),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      Image.asset(
                        Assets.images.giSearch.path,
                        height: 20,
                        semanticLabel: 'search',
                      ),
                      const Tab(text: 'ALL'),
                      const Tab(text: 'GIGGERS'),
                      const Tab(text: 'VIDEOS'),
                      const Tab(text: 'EVENTS'),
                      const Tab(text: 'PRO SERVICES'),
                      const Tab(text: 'CAMPAIGNS'),
                      const Tab(text: 'MEMBERSHIPS'),
                      const Tab(text: 'GIGLIST'),
                    ],
                  ),
                ),
              ],
              body: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: PageView(
                  controller: _controller,
                  onPageChanged: (v) async {
                    if (v == 0) {
                      await const SearchRoute().push(context);
                      tabController.animateTo(current);
                      _controller.animateToPage(
                        current,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.ease,
                      );
                    } else {
                      tabController.animateTo(v);
                      current = v;
                      setState(() {});

                      ref.read(selectorControllerProvider.notifier).update(v);
                    }
                  },
                  children: const [
                    SizedBox(),
                    AllWidget(),
                    ArtistWidget(),
                    VideoWidget(),
                    EventWidget(),
                    ProServiceWidget(),
                    CampaignWidget(),
                    MembershipWidget(),
                    GiglistWidget(),
                  ],
                ),
              ),
            ),
            SupBottom(current: current, hideSup: hideSup),
            Positioned(
              top: 45,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.images.giRedGigger.path,
                        width: 70.w,
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () async {
                          // CalendarRoute().push(context);
                          SheetUtils.proComingSoonSheet(context);
                        },
                        icon: Image.asset(
                          Assets.images.giCalendar.path,
                          fit: BoxFit.cover,
                          width: 20,
                          height: 20,
                          // color: colorGrey,
                        ),
                      ),
                      SizedBox(width: .07.sw),
                      NotiBtn(),
                      SizedBox(width: 0.08.sw),
                      PopupBtn(
                        popOnTap: false,
                        direction: PopoverDirection.bottom,
                        items: [
                          PopupItem(title: 'Logout', onTap: onLogout),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onLogout() async {
    DialogHelper.showLoadingDialog(context);
    await ref.read(authControllerProvider.notifier).logout();

    if (!mounted) return;

    DialogHelper.hideLoading(context);
  }

  Future<void> onRefresh() async {
    var createFrom = ref.watch(selectorControllerProvider);

    if (current == 1) {
      ref.read(recommendedVideoControllerProvider.notifier).refresh();
      ref.read(artistControllerProvider.notifier).refresh();
      ref.read(recommendedGiglistControllerProvider.notifier).refresh();
      ref.read(supControllerProvider(createFrom).notifier).refresh();
      return;
    }

    if (current == 2) {
      ref.read(artistControllerProvider.notifier).refresh();
      ref.read(supControllerProvider(createFrom).notifier).refresh();
      return;
    }

    if (current == 3) {
      ref.read(recommendedVideoControllerProvider.notifier).refresh();
      ref.read(supControllerProvider(createFrom).notifier).refresh();
      return;
    }

    if (current == 4) {
      ref.read(eventControllerProvider.notifier).refresh();
      ref.read(supControllerProvider(createFrom).notifier).refresh();
      return;
    }

    if (current == 8) {
      ref.read(recommendedGiglistControllerProvider.notifier).refresh();
      ref.read(supControllerProvider(createFrom).notifier).refresh();
      return;
    }
  }
}
