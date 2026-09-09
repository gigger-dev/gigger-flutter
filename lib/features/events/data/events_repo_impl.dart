// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../models/basic_response.dart';
import '../../../../models/event_in.dart';
import '../../../../models/event_metadata.dart';
import '../../../../models/event_out.dart';
import '../../../../models/event_update.dart';
import '../../../../models/paginated_response_event_out.dart';

import '../domain/events_repo.dart';
import '../../../../../gen/zx_zlbn_rz_x2_nsa_w_vud_a.dart';

class RXZlbnRzUmVwb0ltcGw implements RXZlbnRzUmVwbw {
  RXZlbnRzUmVwb0ltcGw(this.client);

  final RXZlbnRzQ2xpZW50 client;

  @override
  Future<PaginatedResponseEventOut> z2V0QXBpVjFFdmVudHM({
    int limit = 50,
    int offset = 0,
  }) {
    return client.z2V0QXBpVjFFdmVudHM(
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<EventOut> cG9zdEFwaVYxRXZlbnRz({
    required EventIn body,
  }) {
    return client.cG9zdEFwaVYxRXZlbnRz(
      body: body,
    );
  }

  @override
  Future<List<EventOut>> z2V0QXBpVjFFdmVudHntzWxm() {
    return client.z2V0QXBpVjFFdmVudHntzWxm();
  }

  @override
  Future<EventOut> cGf0Y2hBcGlWmuv2Zw50c0V2Zw50VXVpZA({
    required String eventUuid,
    required EventUpdate body,
  }) {
    return client.cGf0Y2hBcGlWmuv2Zw50c0V2Zw50VXVpZA(
      eventUuid: eventUuid,
      body: body,
    );
  }

  @override
  Future<BasicResponse> zGVsZXRlQXBpVjFFdmVudHNFdmVudFv1aWQ({
    required String eventUuid,
  }) {
    return client.zGVsZXRlQXBpVjFFdmVudHNFdmVudFv1aWQ(
      eventUuid: eventUuid,
    );
  }

  @override
  Future<EventOut> z2V0QXBpVjFFdmVudHNFdmVudFv1aWQ({
    required String eventUuid,
  }) {
    return client.z2V0QXBpVjFFdmVudHNFdmVudFv1aWQ(
      eventUuid: eventUuid,
    );
  }

  @override
  Future<EventMetadata> z2V0QXBpVjFFdmVudHNFdmVudFv1aWrnzxRhZgf0YQ({
    required String eventUuid,
    required String viewerUuid,
  }) {
    return client.z2V0QXBpVjFFdmVudHNFdmVudFv1aWrnzxRhZgf0YQ(
      eventUuid: eventUuid,
      viewerUuid: viewerUuid,
    );
  }

  @override
  Future<EventMetadata> cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkTGlrZQ({
    required String eventUuid,
    required String likerUuid,
  }) {
    return client.cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkTGlrZQ(
      eventUuid: eventUuid,
      likerUuid: likerUuid,
    );
  }

  @override
  Future<EventMetadata> cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkVmlldw({
    required String eventUuid,
    required String viewerUuid,
  }) {
    return client.cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkVmlldw(
      eventUuid: eventUuid,
      viewerUuid: viewerUuid,
    );
  }

  @override
  Future<EventMetadata> cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkUmVzcG9uZA({
    required String eventUuid,
    required String responderUuid,
    required int response,
  }) {
    return client.cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkUmVzcG9uZA(
      eventUuid: eventUuid,
      responderUuid: responderUuid,
      response: response,
    );
  }

  @override
  Future<List<EventOut>> z2V0QXBpVjFFdmVudHntzwFyY2hTzwFyY2hlclV1aWQ({
    required String keywords,
  }) {
    return client.z2V0QXBpVjFFdmVudHntzwFyY2hTzwFyY2hlclV1aWQ(
      keywords: keywords,
    );
  }

  @override
  Future<List<EventOut>> z2V0QXBpVjFFdmVudHNMaXn0UHJvZmlsZvv1aWQ({
    required String profileUuid,
  }) {
    return client.z2V0QXBpVjFFdmVudHNMaXn0UHJvZmlsZvv1aWQ(
      profileUuid: profileUuid,
    );
  }

  @override
  Future<EventOut> cG9zdEFwaVYxRXZlbnRzRXZlbnRby2NlcHrqzxJmb3JtZxjVdWlk({
    required String performerUuid,
    required String eventUuid,
    required String creatorUuid,
  }) {
    return client.cG9zdEFwaVYxRXZlbnRzRXZlbnRby2NlcHrqzxJmb3JtZxjVdWlk(
      performerUuid: performerUuid,
      eventUuid: eventUuid,
      creatorUuid: creatorUuid,
    );
  }

  @override
  Future<EventOut> cG9zdEFwaVYxRXZlbnRzRXZlbnRszWplY3RqzxJmb3JtZxjVdWlk({
    required String performerUuid,
    required String eventUuid,
    required String creatorUuid,
  }) {
    return client.cG9zdEFwaVYxRXZlbnRzRXZlbnRszWplY3RqzxJmb3JtZxjVdWlk(
      performerUuid: performerUuid,
      eventUuid: eventUuid,
      creatorUuid: creatorUuid,
    );
  }
}
