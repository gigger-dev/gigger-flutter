import 'package:mobile_gigger_app/features/events/data/events_provider.dart';
import 'package:mobile_gigger_app/features/events/domain/events_use_case.dart';
import 'package:mobile_gigger_app/models/event_metadata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_metadata_controller.g.dart';

@Riverpod(keepAlive: true)
class EventMetadataController extends _$EventMetadataController {
  @override
  Future<EventMetadata> build({
    required String eventUuid,
    required String viewerUuid,
  }) {
    return getApiV1EventsEventUuidMetadataUseCase(
      eventUuid: eventUuid,
      viewerUuid: viewerUuid,
      repo: ref.read(eventsRepoProvider),
    );
  }

  Future<void> view() async {
    try {
      var state = await future;
      if (state.hasAlreadyViewed) return;

      var r = await postApiV1EventsEventUuidViewUseCase(
        eventUuid: eventUuid,
        viewerUuid: viewerUuid,
        repo: ref.read(eventsRepoProvider),
      );
      this.state = AsyncData(r);
    } catch (_) {}
  }

  Future<void> response({required int response}) async {
    try {
      var r = await postApiV1EventsEventUuidRespondUseCase(
        response: response,
        eventUuid: eventUuid,
        responderUuid: viewerUuid,
        repo: ref.read(eventsRepoProvider),
      );

      state = AsyncData(r);
    } catch (_) {}
  }

  Future<void> toggleLike() async {
    try {
      var r = await postApiV1EventsEventUuidLikeUseCase(
        eventUuid: eventUuid,
        likerUuid: viewerUuid,
        repo: ref.read(eventsRepoProvider),
      );
      state = AsyncData(r);
    } catch (_) {}
  }
}
