import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/calendar/calendar_screen.dart';

import 'event_card.dart';

class UpcomingEventComponent extends StatelessWidget {
  const UpcomingEventComponent({required this.events, super.key});

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Text(
          'Upcoming events',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: getEventsByDate.keys.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final data = getEventsByDate.keys.toList()[index];

            return EventCard(
              date: data,
              isFromSheet: false,
              events: getEventsByDate[data] ?? [],
            );
          },
        )
      ],
    );
  }

  Map<DateTime, List<Event>> get getEventsByDate {
    Map<DateTime, List<Event>> map = {};

    for (var e in events) {
      var date = getDMY(e.start!);

      if (map.containsKey(date)) {
        map[date]?.add(e);
      } else {
        map[date] = [e];
      }
    }

    return map;
  }
}
