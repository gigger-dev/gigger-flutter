import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/features/calendar/providers/calendar_controller.dart';

import 'widgets/backdrop.dart';
import 'widgets/event_card.dart';
import 'widgets/menu_component.dart';
import 'widgets/table_component.dart';
import 'widgets/upcoming_event_component.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  var controller = DraggableScrollableController();
  final now = DateTime.now();
  bool showSheet = false;

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = now;

    controller.addListener(() {
      showSheet = controller.size > 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var events = ref.watch(calendarControllerProvider).valueOrNull ?? [];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          color: Colors.white,
          icon: const Icon(Icons.close),
        ),
        title: const Text(
          'Your Calendar',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        actions: const [MenuComponent()],
      ),
      // floatingActionButton: Visibility(
      //   visible: !showSheet,
      //   child: Padding(
      //     padding: const EdgeInsets.only(bottom: 40),
      //     child: PopupMenuButton(
      //       color: colorRed,
      //       offset: const Offset(0, -220),
      //       // shape: const ToolTipCustomShape(
      //       //   xValue: 50,
      //       //   position: TooltipPosition.down,
      //       // ),
      //       icon: Container(
      //         decoration: const BoxDecoration(
      //           color: colorRed,
      //           shape: BoxShape.circle,
      //         ),
      //         padding: const EdgeInsets.all(8),
      //         child: const Icon(Icons.add, color: colorWhite),
      //       ),
      //       onSelected: (value) {
      //         switch (value) {
      //           case 0:
      //             const CreateCalendarRoute().push(context);
      //             break;
      //           default:
      //         }
      //       },
      //       itemBuilder: (context) => [
      //         const PopupMenuItem(
      //           value: 0,
      //           child: PopupMenuItemText(text: 'New Calenar Event'),
      //         ),
      //         const PopupMenuItem(
      //           value: 1,
      //           child: PopupMenuItemText(text: 'Create Reminder'),
      //         ),
      //         const PopupMenuItem(
      //           value: 2,
      //           child: PopupMenuItemText(text: 'New Appointment'),
      //         ),
      //         const PopupMenuItem(
      //           value: 3,
      //           child: PopupMenuItemText(text: 'Setup Availability'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          TableComponent(
            events: events,
            selectedDate: selectedDate,
            onDateTap: (date) {
              selectedDate = date;
              setState(() {});

              animateTo(haveEvent(events, date) ? 1 : 0);
            },
            onPageChanged: (value) => ref
                .read(calendarControllerProvider.notifier)
                .dateChanged(value.year, value.month),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Backdrop(
              controller: controller,
              selectedDate: selectedDate,
              isShowToday: !selectedDate.isAtSameMomentAs(getDMY(now)),
              front: EventCard(
                isFromSheet: true,
                date: selectedDate,
                events: events
                    .where((e) => getDMY(e.start!) == getDMY(selectedDate))
                    .toList(),
              ),
              back: UpcomingEventComponent(events: events),
              onTodayTap: () {
                final now = getDMY(DateTime.now());

                selectedDate = now;
                setState(() {});

                animateTo(haveEvent(events, now) ? 1 : 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  bool haveEvent(List<Event> events, DateTime date) {
    return events.where((e) {
      var start = getDMY(e.start!);
      var end = getDMY(e.end!);
      var current = getDMY(date);

      return (current.isAtSameMomentAs(start) ||
              current.isAtSameMomentAs(end)) ||
          (current.isAfter(start) && current.isBefore(end));
    }).isNotEmpty;
  }

  Future<void> animateTo(double size) async {
    await controller.animateTo(
      size,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 400),
    );
  }
}

DateTime getDMY(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}
