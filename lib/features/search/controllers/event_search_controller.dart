import 'package:mobile_gigger_app/features/events/data/events_provider.dart';
import 'package:mobile_gigger_app/features/events/domain/events_use_case.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_search_controller.g.dart';

@riverpod
class EventSearchController extends _$EventSearchController {
  @override
  Future<List<EventOut>> build({required String keyword}) {
    return getApiV1EventsSearchSearcherUuidUseCase(
      keywords: keyword,
      repo: ref.read(eventsRepoProvider),
    );
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
