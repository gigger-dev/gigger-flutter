import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/date_time_picker/table_component.dart';
import 'package:table_calendar/table_calendar.dart';

class TableComponent extends StatelessWidget {
  const TableComponent({
    required this.selectedDate,
    required this.events,
    required this.onDateTap,
    required this.onPageChanged,
    super.key,
  });

  final DateTime selectedDate;
  final List<Event> events;
  final ValueChanged<DateTime> onDateTap;
  final ValueChanged<DateTime> onPageChanged;

  @override
  Widget build(BuildContext context) {
    const themeColor = colorTextRed;

    final now = DateTime.now();

    return TableCalendar<Event>(
      rowHeight: 45,
      focusedDay: selectedDate,
      lastDay: DateTime(now.year + 100),
      firstDay: DateTime(now.year - 100),
      onPageChanged: onPageChanged,
      onDayLongPressed: (selectedDay, focusedDay) {},
      onDaySelected: (v, _) => onDateTap(getDMY(v)),
      selectedDayPredicate: (day) => getDMY(day).isAtSameMomentAs(selectedDate),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(fontSize: 15, color: Colors.white),
        leftChevronIcon: Icon(
          CupertinoIcons.left_chevron,
          color: Colors.white,
        ),
        rightChevronIcon: Icon(
          CupertinoIcons.right_chevron,
          color: Colors.white,
        ),
      ),
      calendarStyle: CalendarStyle(
        markerSize: 4,
        markersAnchor: 1.4,
        markersMaxCount: 1,
        defaultTextStyle: const TextStyle(fontSize: 13, color: Colors.white),
        selectedTextStyle: const TextStyle(fontSize: 13, color: Colors.white),
        todayTextStyle: const TextStyle(color: themeColor, fontSize: 13),
        todayDecoration: const BoxDecoration(shape: BoxShape.circle),
        markerDecoration:
            const BoxDecoration(color: themeColor, shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: themeColor),
        ),
      ),
      eventLoader: (date) => events.where((e) {
        var start = getDMY(e.start!);
        var end = getDMY(e.end!);
        var current = getDMY(date);

        return (current.isAtSameMomentAs(start) ||
                current.isAtSameMomentAs(end)) ||
            (current.isAfter(start) && current.isBefore(end));
      }).toList(),
    );
  }
}
