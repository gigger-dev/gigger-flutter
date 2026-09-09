import 'package:mobile_gigger_app/core/helpers/event_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reminder_controller.g.dart';

// @Riverpod(keepAlive: true)
// class ReminderController extends _$ReminderController {
//   @override
//   Future<UnmodifiableListView<Event>?> build(List<EventOut> items) {
//     var ids = items.map((e) => e.uuid).toList();
//     return EventHelper.getEvents(ids);
//   }
// }

@Riverpod(keepAlive: true)
class IsReminder extends _$IsReminder {
  @override
  Future<bool> build(String uuid) {
    return EventHelper.checkEvent(uuid);
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
