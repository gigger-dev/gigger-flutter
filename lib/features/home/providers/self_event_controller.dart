import 'package:mobile_gigger_app/features/events/data/events_provider.dart';
import 'package:mobile_gigger_app/features/events/domain/events_use_case.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'self_event_controller.g.dart';

@Riverpod(keepAlive: true)
class SelfEventController extends _$SelfEventController {
  @override
  Future<List<EventOut>> build() async {
    var r = await getApiV1EventsSelfUseCase(ref.read(eventsRepoProvider));
    r.sort((a, b) => a.startTime.toLocal().compareTo(b.startTime.toLocal()));
    return r;
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
