import 'package:intl/intl.dart';

extension DateExtension on DateFormat {
  String? tryFormat(DateTime? date) {
    if (date == null) return null;

    try {
      return format(date.toLocal());
    } catch (e) {
      return null;
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime get clean => DateTime(year, month, day, hour, minute);
}
