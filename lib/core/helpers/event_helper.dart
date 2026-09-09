import 'package:device_calendar/device_calendar.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:mobile_gigger_app/core/utils/get_share_url.dart';

class EventHelper {
  static Future<bool> hasPermissions() async {
    var permissionsGranted = await DeviceCalendarPlugin().hasPermissions();
    return permissionsGranted.isSuccess;
  }

  static Future<bool> requestPermission() async {
    var permissionsGranted = await DeviceCalendarPlugin().requestPermissions();
    return permissionsGranted.isSuccess;
  }

  static Future<void> createEvent({
    required String name,
    required String eventId,
    required String location,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    Duration? reminder,
  }) async {
    var calendarId = await getCalendarId();

    var timezone = await FlutterTimezone.getLocalTimezone();
    var _currentLocation = timeZoneDatabase.locations[timezone];

    if (_currentLocation == null) return;

    await DeviceCalendarPlugin().createOrUpdateEvent(Event(
      calendarId,
      title: name,
      location: location,
      status: EventStatus.Confirmed,
      availability: Availability.Free,
      url: Uri.parse(getEventShareUrl(eventId)),
      end: TZDateTime.from(endTime, _currentLocation),
      start: TZDateTime.from(startTime, _currentLocation),
      description: '$description\n${getEventShareUrl(eventId)}',
      reminders:
          reminder == null ? null : [Reminder(minutes: reminder.inMinutes)],
    ));
  }

  static Future<bool> checkEvent(String uuid) async {
    var calendarId = await getCalendarId();
    var r = await DeviceCalendarPlugin().retrieveEvents(calendarId, null);
    var data = r.data;
    if (data == null) return false;

    return data.any((e) => '${e.url}'.endsWith(uuid));
  }

  static Future<bool> deleteEvent(String uuid) async {
    var calendarId = await getCalendarId();
    var r = await DeviceCalendarPlugin().deleteEvent(calendarId, uuid);
    return r.data ?? false;
  }

  static Future<List<Event>> retrieveEvents({int? year, int? month}) async {
    var now = DateTime.now();

    year ??= now.year;
    month ??= now.month;

    var startDate = DateTime(year, month);

    var calendarId = await getCalendarId();
    var r = await DeviceCalendarPlugin().retrieveEvents(
      calendarId,
      RetrieveEventsParams(
        startDate: startDate,
        endDate: startDate.add(Duration(days: 30)),
      ),
    );
    return r.data?.toList() ?? [];
  }

  static Future<String> getCalendarId() async {
    var deviceCalendar = DeviceCalendarPlugin();

    var calendars = await deviceCalendar.retrieveCalendars();
    var gigger = calendars.data?.where((e) => e.name == 'Gigger').firstOrNull;
    if (gigger != null) return gigger.id!;

    var r = await deviceCalendar.createCalendar('Gigger');
    return r.data!;
  }
}
