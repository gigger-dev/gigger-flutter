import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/notification/presentation/widgets/chat_delete_confirm_dialog.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatExpansionCard extends StatefulWidget {
  const ChatExpansionCard({
    super.key,
    required this.title,
    required this.controller,
    this.initiallyExpanded = false,
  });

  final String title;
  final bool initiallyExpanded;
  final StreamChannelListController controller;

  @override
  State<ChatExpansionCard> createState() => _ChatExpansionCardState();
}

class _ChatExpansionCardState extends State<ChatExpansionCard> {
  var isExpanded = false;
  late Stream<int> totalUnreadCountStream;
  late Stream<int> currentItemCount;

  @override
  void initState() {
    super.initState();
    totalUnreadCountStream = getTotalUnreadCountStream;
    currentItemCount = getCurrentItems;
  }

  Stream<int> get getTotalUnreadCountStream {
    try {
      return widget.controller.client.state.totalUnreadCountStream
          .asBroadcastStream();
    } catch (e) {
      return Stream.empty();
    }
  }

  Stream<int> get getCurrentItems {
    try {
      return Stream.periodic(
        Duration(seconds: 1),
        (_) => widget.controller.currentItems.length,
      ).asBroadcastStream();
    } catch (e) {
      return Stream.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        dense: true,
        textColor: colorWhite,
        iconColor: colorWhite,
        collapsedTextColor: colorWhite,
        collapsedIconColor: colorWhite,
        initiallyExpanded: widget.initiallyExpanded,
        onExpansionChanged: (value) {
          isExpanded = value;
          setState(() {});
        },
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextViewWidget(text: widget.title, textSize: 18),
                Container(
                  height: .5,
                  width: 90,
                  margin: const EdgeInsets.only(top: 3),
                  color: colorWhite,
                ),
              ],
            ),
            const Spacer(),
            if (!isExpanded)
              StreamBuilder(
                stream: totalUnreadCountStream,
                builder: (context, snapshot) {
                  if ((snapshot.data ?? 0) == 0) return SizedBox();

                  return const CircleAvatar(
                    radius: 2,
                    backgroundColor: colorRed,
                  );
                },
              )
          ],
        ),
        childrenPadding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: StreamBuilder(
                stream: currentItemCount,
                builder: (context, snapshot) {
                  var count = snapshot.data ?? 0;
                  return TextViewWidget(
                    text: '$count message${count > 1 ? 's' : ''}',
                    color: colorGrey,
                  );
                },
              ),
            ),
          ),
          StreamChannelListView(
            shrinkWrap: true,
            primary: false,
            controller: widget.controller,
            emptyBuilder: (context) => SizedBox(
              height: .2.sh,
              child: Center(child: TextViewWidget(text: 'EMPTY')),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            loadingBuilder: (context) => Center(
              child: Transform.scale(
                scale: .6,
                child: CircularProgressIndicator(),
              ),
            ),
            onChannelTap: (c) => ChatRoute($extra: c).push(context),
            onChannelLongPress: (c) => SheetUtils.showSimpleSheet(
              context: context,
              child: ChatDeleteConfirmDialog(c),
            ),
          ),
        ],
      ),
    );
  }
}
