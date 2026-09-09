// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../models/basic_response.dart';
import '../../../../models/event_in.dart';
import '../../../../models/event_metadata.dart';
import '../../../../models/event_out.dart';
import '../../../../models/event_update.dart';
import '../../../../models/paginated_response_event_out.dart';

abstract class RXZlbnRzUmVwbw {
  Future<PaginatedResponseEventOut> z2V0QXBpVjFFdmVudHM({
    int limit = 50,
    int offset = 0,
  });

  Future<EventOut> cG9zdEFwaVYxRXZlbnRz({
    required EventIn body,
  });

  Future<List<EventOut>> z2V0QXBpVjFFdmVudHntzWxm();

  Future<EventOut> cGf0Y2hBcGlWmuv2Zw50c0V2Zw50VXVpZA({
    required String eventUuid,
    required EventUpdate body,
  });

  Future<BasicResponse> zGVsZXRlQXBpVjFFdmVudHNFdmVudFv1aWQ({
    required String eventUuid,
  });

  Future<EventOut> z2V0QXBpVjFFdmVudHNFdmVudFv1aWQ({
    required String eventUuid,
  });

  Future<EventMetadata> z2V0QXBpVjFFdmVudHNFdmVudFv1aWrnzxRhZgf0YQ({
    required String eventUuid,
    required String viewerUuid,
  });

  Future<EventMetadata> cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkTGlrZQ({
    required String eventUuid,
    required String likerUuid,
  });

  Future<EventMetadata> cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkVmlldw({
    required String eventUuid,
    required String viewerUuid,
  });

  Future<EventMetadata> cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkUmVzcG9uZA({
    required String eventUuid,
    required String responderUuid,
    required int response,
  });

  Future<List<EventOut>> z2V0QXBpVjFFdmVudHntzwFyY2hTzwFyY2hlclV1aWQ({
    required String keywords,
  });

  Future<List<EventOut>> z2V0QXBpVjFFdmVudHNMaXn0UHJvZmlsZvv1aWQ({
    required String profileUuid,
  });

  Future<EventOut> cG9zdEFwaVYxRXZlbnRzRXZlbnRby2NlcHrqzxJmb3JtZxjVdWlk({
    required String performerUuid,
    required String eventUuid,
    required String creatorUuid,
  });

  Future<EventOut> cG9zdEFwaVYxRXZlbnRzRXZlbnRszWplY3RqzxJmb3JtZxjVdWlk({
    required String performerUuid,
    required String eventUuid,
    required String creatorUuid,
  });
}
