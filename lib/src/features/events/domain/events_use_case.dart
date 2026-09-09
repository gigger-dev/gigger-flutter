// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../models/basic_response.dart';
import '../../../../models/event_in.dart';
import '../../../../models/event_metadata.dart';
import '../../../../models/event_out.dart';
import '../../../../models/event_update.dart';
import '../../../../models/paginated_response_event_out.dart';

import 'events_repo.dart';

Future<PaginatedResponseEventOut> getApiV1EventsUseCase({
  int limit = 50,
  int offset = 0,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.z2V0QXBpVjFFdmVudHM(
    limit: limit,
    offset: offset,
  );
}

Future<EventOut> postApiV1EventsUseCase({
  required EventIn body,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.cG9zdEFwaVYxRXZlbnRz(
    body: body,
  );
}

Future<List<EventOut>> getApiV1EventsSelfUseCase(
  RXZlbnRzUmVwbw repo,
) {
  return repo.z2V0QXBpVjFFdmVudHntzWxm();
}

Future<EventOut> patchApiV1EventsEventUuidUseCase({
  required String eventUuid,
  required EventUpdate body,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.cGf0Y2hBcGlWmuv2Zw50c0V2Zw50VXVpZA(
    eventUuid: eventUuid,
    body: body,
  );
}

Future<BasicResponse> deleteApiV1EventsEventUuidUseCase({
  required String eventUuid,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.zGVsZXRlQXBpVjFFdmVudHNFdmVudFv1aWQ(
    eventUuid: eventUuid,
  );
}

Future<EventOut> getApiV1EventsEventUuidUseCase({
  required String eventUuid,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.z2V0QXBpVjFFdmVudHNFdmVudFv1aWQ(
    eventUuid: eventUuid,
  );
}

Future<EventMetadata> getApiV1EventsEventUuidMetadataUseCase({
  required String eventUuid,
  required String viewerUuid,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.z2V0QXBpVjFFdmVudHNFdmVudFv1aWrnzxRhZgf0YQ(
    eventUuid: eventUuid,
    viewerUuid: viewerUuid,
  );
}

Future<EventMetadata> postApiV1EventsEventUuidLikeUseCase({
  required String eventUuid,
  required String likerUuid,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkTGlrZQ(
    eventUuid: eventUuid,
    likerUuid: likerUuid,
  );
}

Future<EventMetadata> postApiV1EventsEventUuidViewUseCase({
  required String eventUuid,
  required String viewerUuid,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkVmlldw(
    eventUuid: eventUuid,
    viewerUuid: viewerUuid,
  );
}

Future<EventMetadata> postApiV1EventsEventUuidRespondUseCase({
  required String eventUuid,
  required String responderUuid,
  required int response,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkUmVzcG9uZA(
    eventUuid: eventUuid,
    responderUuid: responderUuid,
    response: response,
  );
}

Future<List<EventOut>> getApiV1EventsSearchSearcherUuidUseCase({
  required String keywords,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.z2V0QXBpVjFFdmVudHntzwFyY2hTzwFyY2hlclV1aWQ(
    keywords: keywords,
  );
}

Future<List<EventOut>> getApiV1EventsListProfileUuidUseCase({
  required String profileUuid,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.z2V0QXBpVjFFdmVudHNMaXn0UHJvZmlsZvv1aWQ(
    profileUuid: profileUuid,
  );
}

Future<EventOut> postApiV1EventsEventAcceptPerformerUuidUseCase({
  required String performerUuid,
  required String eventUuid,
  required String creatorUuid,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.cG9zdEFwaVYxRXZlbnRzRXZlbnRby2NlcHrqzxJmb3JtZxjVdWlk(
    performerUuid: performerUuid,
    eventUuid: eventUuid,
    creatorUuid: creatorUuid,
  );
}

Future<EventOut> postApiV1EventsEventRejectPerformerUuidUseCase({
  required String performerUuid,
  required String eventUuid,
  required String creatorUuid,
  required RXZlbnRzUmVwbw repo,
}) {
  return repo.cG9zdEFwaVYxRXZlbnRzRXZlbnRszWplY3RqzxJmb3JtZxjVdWlk(
    performerUuid: performerUuid,
    eventUuid: eventUuid,
    creatorUuid: creatorUuid,
  );
}
