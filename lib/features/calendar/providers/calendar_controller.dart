import 'package:device_calendar/device_calendar.dart';
import 'package:mobile_gigger_app/core/helpers/event_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_controller.g.dart';

@Riverpod(keepAlive: true)
class CalendarController extends _$CalendarController {
  @override
  Future<List<Event>> build() {
    return EventHelper.retrieveEvents();
  }

  Future<void> dateChanged(int year, int month) async {
    await update((_) => EventHelper.retrieveEvents(year: year, month: month));
  }
}
