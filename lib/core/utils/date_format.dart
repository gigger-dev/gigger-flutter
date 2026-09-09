import 'package:intl/intl.dart';

String supDateFormat(DateTime date) {
  return DateFormat('d MMMM - h.mma').format(date.toLocal()).toLowerCase();
}

String birdayDateFormat(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date.toLocal());
}

DateTime birdayDateParse(String date) {
  return DateFormat('yyyy-MM-dd').parse(date);
}

String draftDateFormat(DateTime date) {
  return DateFormat('EEE dd MMM yyyy\nhh:mma').format(date.toLocal());
}

String? eventDateFormat(DateTime? startTime, DateTime? endTime) {
  if (startTime == null || endTime == null) return null;

  if (startTime.day != endTime.day) {
    return '${DateFormat('dd/MM/yyyy hh:mma').format(startTime)} - ${DateFormat('dd/MM/yyyy hh:mma').format(endTime)}';
  }

  return '${DateFormat('dd MMMM yyyy').format(startTime)} - From ${DateFormat('HH:mm').format(startTime)} to ${DateFormat('HH:mm').format(endTime)}';
}
