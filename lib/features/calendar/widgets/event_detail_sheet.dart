import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class EventDetailSheet extends StatelessWidget {
  const EventDetailSheet(this.data, {super.key});

  final Event data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextViewWidget(
                text: data.title ?? '',
                textSize: 30,
                height: 1,
              ),
              const SizedBox(height: 20),
              // TextViewWidget(
              //   text: DateFormat('EEEE, dd MMMM yyyy').format(data.date),
              //   color: colorTextGrey,
              // ),
              // const SizedBox(height: 20),
              // Row(
              //   children: [
              //     const Icon(CupertinoIcons.time, color: colorWhite, size: 12),
              //     const SizedBox(width: 4),
              //     TextViewWidget(text: data.hour)
              //   ],
              // ),
              const SizedBox(height: 4),
              // CupertinoButton(
              //   minSize: 0,
              //   padding: EdgeInsets.zero,
              //   onPressed: () {
              //     context.pop();
              //     SheetUtils.showSheet(
              //       height: .6.sh,
              //       context: context,
              //       isScrollControlled: true,
              //       children: [EventLocationSheet(data)],
              //     );
              //   },
              //   child: Row(
              //     children: [
              //       const Icon(Icons.location_on, color: colorWhite, size: 12),
              //       const SizedBox(width: 4),
              //       TextViewWidget(text: data.location)
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20),
              const TextViewWidget(text: 'Description'),
              const SizedBox(height: 4),
              TextViewWidget(text: data.description ?? '', textSize: 12),
              const SizedBox(height: 20),
              const Row(
                children: [
                  TextViewWidget(text: 'Participants'),
                  SizedBox(width: 10),
                  // AvatarRow(
                  //   imgs: ['', '', '', '', ''],
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              const TextViewWidget(text: 'Reminder'),
              const TextViewWidget(text: '1 day before', textSize: 12),
            ],
          ),
        ),
        const Divider(thickness: 1),
        Row(
          children: [
            _ActionBtn(icon: Assets.images.giShare.path, label: 'Share'),
            _ActionBtn(icon: Assets.images.giFollow.path, label: 'Follow'),
            const _ActionBtn(icon: CupertinoIcons.phone, label: 'Phone'),
            _ActionBtn(icon: Assets.images.giMessage.path, label: 'Message'),
          ],
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.icon,
    required this.label,
  });

  final Object icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoButton(
        onPressed: () {},
        child: Column(
          children: [
            icon is String
                ? Image.asset('$icon', height: 22, width: 22)
                : Icon(icon as IconData, color: colorWhite),
            const SizedBox(height: 4),
            TextViewWidget(text: label, textSize: 12)
          ],
        ),
      ),
    );
  }
}
