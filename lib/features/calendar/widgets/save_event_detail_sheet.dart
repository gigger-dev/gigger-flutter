import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/duration_ago.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SaveEventDetailSheet extends StatelessWidget {
  const SaveEventDetailSheet(this.data, {super.key});

  final Event data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextViewWidget(text: data.title ?? '', textSize: 30, height: 1),
          // TextViewWidget(text: 'data.tag', textSize: 14, height: 1),
          const SizedBox(height: 20),
          TextViewWidget(
            text: DateFormat('EEEE, dd MMMM yyyy').format(data.start!),
            color: colorTextGrey,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(CupertinoIcons.time, color: colorWhite, size: 12),
              const SizedBox(width: 4),
              TextViewWidget(text: DateFormat('hh:mm a').format(data.start!))
            ],
          ),
          const SizedBox(height: 4),
          CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.zero,
            onPressed: () {
              // context.pop();
              // SheetUtils.showSheet(
              //   context: context,
              //   children: [EventLocationSheet(data)],
              // );
            },
            child: Row(
              children: [
                const Icon(Icons.location_on, color: colorWhite, size: 12),
                const SizedBox(width: 4),
                TextViewWidget(text: data.location ?? '')
              ],
            ),
          ),
          const SizedBox(height: 20),
          const TextViewWidget(text: 'Description'),
          const SizedBox(height: 4),
          TextViewWidget(text: data.description ?? '', textSize: 12),
          // const SizedBox(height: 20),
          // const Row(
          //   children: [
          //     TextViewWidget(text: 'Participants'),
          //     SizedBox(width: 10),
          //     // AvatarRow(
          //     //   imgs: ['', '', '', '', ''],
          //     // ),
          //   ],
          // ),
          const SizedBox(height: 20),
          if (data.reminders != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextViewWidget(text: 'Reminder'),
                TextViewWidget(
                  text: durationAgo(
                    Duration(minutes: data.reminders!.first.minutes!),
                  ),
                  textSize: 12,
                ),
              ],
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size.zero,
                  // backgroundColor: colorRed,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                child: const TextViewWidget(text: 'Going', textSize: 12),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                child: const TextViewWidget(text: 'Maybe', textSize: 12),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                child: const TextViewWidget(text: 'Interested', textSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
