import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/noti_count_provider.dart';
import 'package:mobile_gigger_app/features/notification/presentation/widgets/notification_widget.dart';
import 'package:mobile_gigger_app/features/notification/presentation/widgets/support_donation_widget.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'widgets/message_widget.dart';

class NotiScreen extends ConsumerStatefulWidget {
  const NotiScreen({super.key, this.index = 0});

  final int index;

  @override
  ConsumerState<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends ConsumerState<NotiScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: 3, vsync: this, initialIndex: widget.index);
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: BackButton(onPressed: context.pop),
        iconTheme: const IconThemeData(color: colorWhite),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
        title: TabBar(
          controller: _controller,
          dividerColor: colorOrangeRed,
          indicatorColor: colorOrangeRed,
          tabAlignment: TabAlignment.center,
          labelStyle: const TextStyle(fontSize: 10, color: colorWhite),
          // onTap: (value) {
          //   if (value == 2) _controller.index = _controller.previousIndex;
          // },
          tabs: [
            _Tab(
              value: 0,
              label: 'Notifications',
              controller: _controller,
              count: ref.watch(notiCountProvider),
              icon: Assets.images.giNotificationOutline,
              activeIcon: Assets.images.giNotification,
            ),
            StreamBuilder(
              stream:
                  StreamChat.of(context).client.state.totalUnreadCountStream,
              builder: (context, snapshot) {
                return _Tab(
                  value: 1,
                  label: 'Messages',
                  count: snapshot.data,
                  controller: _controller,
                  icon: Assets.images.giMessage,
                  activeIcon: Assets.images.giMessageFill,
                );
              },
            ),
            _Tab(
              value: 2,
              label: 'Support',
              controller: _controller,
              icon: Assets.images.giSupport,
              activeIcon: Assets.images.giSupportFill,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          NotificationWidget(),
          MessageWidget(),
          SupportDonationWidget(),
        ],
      ),
      bottomNavigationBar: _controller.index != 1
          ? null
          : Padding(
              padding: EdgeInsets.only(
                left: 60,
                bottom: 30,
                top: 30,
                right: _controller.index == 1 ? 10 : 60,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => UserSearchRoute().push(context),
                      style: const TextStyle(fontSize: 14, color: colorWhite),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Search ...',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        hintStyle:
                            TextStyle(fontSize: 14, color: colorTextGrey),
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () => UserSearchRoute().push(context),
                    style: FilledButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Icon(Icons.edit_outlined, size: 18),
                  ),
                ],
              ),
            ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.value,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.controller,
    this.count,
  });

  final int value;
  final String label;
  final int? count;
  final AssetGenImage icon;
  final TabController controller;
  final AssetGenImage activeIcon;

  @override
  Widget build(BuildContext context) {
    Widget child = Image.asset(
      controller.index == value ? activeIcon.path : icon.path,
      color: controller.index == value ? null : colorWhite,
      width: 22,
      height: 22,
    );

    if (count != null && count! > 0) {
      child = Badge.count(
        smallSize: 1,
        largeSize: 11,
        count: count ?? 0,
        textColor: colorWhite,
        padding: EdgeInsets.zero,
        backgroundColor: colorRed,
        child: child,
      );
    }

    return Tab(icon: child, text: label);
  }
}
