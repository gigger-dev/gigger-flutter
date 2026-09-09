import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/connection/providers/follower_controller.dart';
import 'package:mobile_gigger_app/features/connection/providers/following_controller.dart';
import 'package:mobile_gigger_app/features/connection/widgets/connection_tab.dart';
import 'package:mobile_gigger_app/features/connection/widgets/follower_widget.dart';
import 'package:mobile_gigger_app/features/connection/widgets/following_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/metadata_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ConnectionScreen extends ConsumerStatefulWidget {
  const ConnectionScreen({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  ConsumerState<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends ConsumerState<ConnectionScreen>
    with TickerProviderStateMixin {
  int index = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var uuid =
        ref.watch(profileControllerProvider.select((v) => v.value!.uuid));

    var metadata = ref.watch(metadataControllerProvider(uuid)).valueOrNull;

    var followersCount = metadata?.followersCount ?? 0;
    var followingCount = metadata?.followingCount ?? 0;

    return Scaffold(
      backgroundColor: colorBlack,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colorBlack,
        title: const TextViewWidget(text: 'Connections'),
        iconTheme: const IconThemeData(color: colorWhite),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          )
        ],
        bottom: TabBar(
          onTap: (i) => onTap(i, uuid),
          dividerHeight: 0,
          indicatorColor: colorRed,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            ConnectionTab(
              '$followersCount\nFollower${followersCount < 2 ? '' : 's'}',
            ),
            ConnectionTab(
              '$followingCount\nFollowing${followingCount < 2 ? '' : 's'}',
            ),
            ConnectionTab('0\nSubscription', color: colorTextGrey),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          RefreshIndicator(
            onRefresh: () => onRefresh(uuid),
            child: FollowerWidget(uuid),
          ),
          RefreshIndicator(
            onRefresh: () => onRefresh(uuid),
            child: FollowingWidget(uuid),
          ),
          const SizedBox(),
        ],
      ),
    );
  }

  Future<void> onRefresh(String uuid) async {
    ref.read(metadataControllerProvider(uuid).notifier).refresh();
    ref.read(followerControllerProvider(uuid).notifier).refresh();
    ref.read(followingControllerProvider(uuid).notifier).refresh();

    await Future.delayed(const Duration(seconds: 1));
  }

  void onTap(int value, String uuid) {
    if (value == 2) {
      tabController.index = index;
      setState(() {});
      return;
    }

    ref.read(metadataControllerProvider(uuid).notifier).refresh();

    index = value;
    setState(() {});
  }
}
