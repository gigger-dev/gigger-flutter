import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:table_calendar/table_calendar.dart';

class TableComponent extends StatelessWidget {
  const TableComponent({
    super.key,
    this.firstDay,
    this.focusedDay,
    required this.selected,
    required this.onDayTap,
  });

  final DateTime? firstDay;
  final DateTime? focusedDay;
  final List<DateTime> selected;
  final ValueChanged<DateTime> onDayTap;

  @override
  Widget build(BuildContext context) {
    const themeColor = colorTextRed;

    final now = DateTime.now();

    return TableCalendar(
      rowHeight: 45,
      lastDay: DateTime(now.year + 100),
      focusedDay: focusedDay ?? DateTime.now(),
      startingDayOfWeek: StartingDayOfWeek.monday,
      firstDay: firstDay ?? DateTime(now.year - 100),
      selectedDayPredicate: (day) => selected.contains(getDMY(day)),
      onDaySelected: (selectedDay, _) => onDayTap(getDMY(selectedDay)),
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
        todayDecoration: BoxDecoration(shape: BoxShape.circle),
        todayTextStyle: TextStyle(color: themeColor, fontSize: 13),
        weekendTextStyle: TextStyle(fontSize: 13, color: Colors.white),
        defaultTextStyle: TextStyle(fontSize: 13, color: Colors.white),
        selectedTextStyle: TextStyle(fontSize: 13, color: Colors.white),
        disabledTextStyle: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        markerDecoration:
            BoxDecoration(color: themeColor, shape: BoxShape.circle),
        selectedDecoration:
            BoxDecoration(shape: BoxShape.circle, color: themeColor),
      ),
    );
  }
}

DateTime getDMY(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}
