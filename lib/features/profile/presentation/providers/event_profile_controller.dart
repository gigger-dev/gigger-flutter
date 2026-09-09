import 'package:mobile_gigger_app/features/events/data/events_provider.dart';
import 'package:mobile_gigger_app/features/events/domain/events_use_case.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_profile_controller.g.dart';

@riverpod
class EventProfileController extends _$EventProfileController {
  @override
  Future<List<EventOut>> build(String profileUuid) {
    return getApiV1EventsListProfileUuidUseCase(
      repo: ref.read(eventsRepoProvider),
      profileUuid: profileUuid,
    );
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
