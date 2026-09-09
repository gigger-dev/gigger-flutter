import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/calendar/widgets/save_event_detail_sheet.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

import 'event_detail_sheet.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.date,
    required this.events,
    super.key,
    required this.isFromSheet,
  });

  final DateTime date;
  final List<Event> events;
  final bool isFromSheet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('EEEE, dd MMMM').format(date),
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
            Text(
              getDiffText(date, DateTime.now()),
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          itemCount: events.length,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            return _EventItem(
              data: events[index],
              isFromSheet: isFromSheet,
            );
          },
        )
      ],
    );
  }

  String getDiffText(DateTime from, DateTime to) {
    final inDays = from.difference(to).inDays;
    if (inDays > 0) return 'in $inDays day${inDays > 1 ? 's' : ''}';

    if (from.isAtSameMomentAs(to)) return 'Today';

    return 'in 1 day';
  }
}

class _EventItem extends StatelessWidget {
  const _EventItem({
    required this.data,
    required this.isFromSheet,
  });

  final Event data;
  final bool isFromSheet;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () => onTap(context),
      contentPadding: const EdgeInsets.only(left: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              DateFormat('hh:mm a').format(data.start!),
              style: const TextStyle(fontSize: 13, color: colorWhite),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              data.title ?? '',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 13,
                color: colorWhite,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.more_vert, color: colorWhite),
        ],
      ),
    );
  }

  void onTap(BuildContext context) {
    SheetUtils.showSheet(
      context: context,
      isScrollControlled: true,
      height: !isFromSheet ? .65.sh : .6.sh,
      padding: const EdgeInsets.only(top: 20),
      actionPadding: const EdgeInsets.symmetric(horizontal: 10),
      // decoration: !isFromSheet
      //     ? null
      //     : BoxDecoration(
      //         borderRadius: BorderRadius.circular(20),
      //         image: DecorationImage(
      //           opacity: .2,
      //           fit: BoxFit.cover,
      //           image: CachedNetworkImageProvider(data.thumbnail),
      //         ),
      //       ),
      foregroundDecoration: !isFromSheet
          ? null
          : const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorBlack,
                  Colors.transparent,
                  colorBlack,
                ],
                stops: [0, .5, .9],
              ),
            ),
      action: CupertinoButton(
        onPressed: () {},
        minSize: 0,
        padding: EdgeInsets.zero,
        child: const TextViewWidget(
          text: 'Edit',
          textSize: 12,
          color: colorTextRed,
        ),
      ),
      children: [
        isFromSheet ? SaveEventDetailSheet(data) : EventDetailSheet(data),
      ],
    );
  }
}
