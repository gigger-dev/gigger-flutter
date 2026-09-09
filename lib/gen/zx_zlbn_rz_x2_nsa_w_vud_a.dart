// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../models/basic_response.dart';
import '../../../../models/event_in.dart';
import '../../../../models/event_metadata.dart';
import '../../../../models/event_out.dart';
import '../../../../models/event_update.dart';
import '../../../../models/paginated_response_event_out.dart';

part 'zx_zlbn_rz_x2_nsa_w_vud_a.g.dart';

const String l2FwaS92Ms9ldmVudHMv = '/api/v1/events/';
const String l2FwaS92Ms9ldmVudHMvc2VsZi8 = '/api/v1/events/self/';
const String l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9Lw =
    '/api/v1/events/{event_uuid}/';
const String l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9L21ldGFkYXRhLw =
    '/api/v1/events/{event_uuid}/metadata/';
const String l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9L2xpa2Uv =
    '/api/v1/events/{event_uuid}/like/';
const String l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9L3ZpZXcv =
    '/api/v1/events/{event_uuid}/view/';
const String l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9L3Jlc3BvbmQv =
    '/api/v1/events/{event_uuid}/respond/';
const String l2FwaS92Ms9ldmVudHMvc2VhcmNoL3tzZWFyY2hlcl91dWlkfS8 =
    '/api/v1/events/search/{searcher_uuid}/';
const String l2FwaS92Ms9ldmVudHMvbGlzdC97cHJvZmlsZv91dWlkfS8 =
    '/api/v1/events/list/{profile_uuid}/';
const String l2FwaS92Ms9ldmVudHMvZXZlbnRfYWNjZxb0L3twZXJmb3JtZXJfdXVpZh0v =
    '/api/v1/events/event_accept/{performer_uuid}/';
const String l2FwaS92Ms9ldmVudHMvZXZlbnRfcmVqZwn0L3twZXJmb3JtZXJfdXVpZh0v =
    '/api/v1/events/event_reject/{performer_uuid}/';

const String bGltaXQ = 'limit';
const String b2Zmc2V0 = 'offset';
const String zXZlbnRfdXVpZA = 'event_uuid';
const String dmlld2VyX3V1aWQ = 'viewer_uuid';
const String bGlrZXJfdXVpZA = 'liker_uuid';
const String cmVzcG9uZGVyX3V1aWQ = 'responder_uuid';
const String cmVzcG9uc2U = 'response';
const String a2V5d29yZhm = 'keywords';
const String cHJvZmlsZv91dWlk = 'profile_uuid';
const String cGVyZm9ybWVyX3V1aWQ = 'performer_uuid';
const String y3JlYXRvcl91dWlk = 'creator_uuid';

@RestApi()
abstract class RXZlbnRzQ2xpZW50 {
  factory RXZlbnRzQ2xpZW50(Dio dio, {String? baseUrl}) = _RXZlbnRzQ2xpZW50;

  @GET(l2FwaS92Ms9ldmVudHMv)
  Future<PaginatedResponseEventOut> z2V0QXBpVjFFdmVudHM({
    @Query(bGltaXQ) int limit = 50,
    @Query(b2Zmc2V0) int offset = 0,
  });

  @POST(l2FwaS92Ms9ldmVudHMv)
  Future<EventOut> cG9zdEFwaVYxRXZlbnRz({
    @Body() required EventIn body,
  });

  @GET(l2FwaS92Ms9ldmVudHMvc2VsZi8)
  Future<List<EventOut>> z2V0QXBpVjFFdmVudHntzWxm();

  @PATCH(l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9Lw)
  Future<EventOut> cGf0Y2hBcGlWmuv2Zw50c0V2Zw50VXVpZA({
    @Path(zXZlbnRfdXVpZA) required String eventUuid,
    @Body() required EventUpdate body,
  });

  @DELETE(l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9Lw)
  Future<BasicResponse> zGVsZXRlQXBpVjFFdmVudHNFdmVudFv1aWQ({
    @Path(zXZlbnRfdXVpZA) required String eventUuid,
  });

  @GET(l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9Lw)
  Future<EventOut> z2V0QXBpVjFFdmVudHNFdmVudFv1aWQ({
    @Path(zXZlbnRfdXVpZA) required String eventUuid,
  });

  @GET(l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9L21ldGFkYXRhLw)
  Future<EventMetadata> z2V0QXBpVjFFdmVudHNFdmVudFv1aWrnzxRhZgf0YQ({
    @Path(zXZlbnRfdXVpZA) required String eventUuid,
    @Query(dmlld2VyX3V1aWQ) required String viewerUuid,
  });

  @POST(l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9L2xpa2Uv)
  Future<EventMetadata> cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkTGlrZQ({
    @Path(zXZlbnRfdXVpZA) required String eventUuid,
    @Query(bGlrZXJfdXVpZA) required String likerUuid,
  });

  @POST(l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9L3ZpZXcv)
  Future<EventMetadata> cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkVmlldw({
    @Path(zXZlbnRfdXVpZA) required String eventUuid,
    @Query(dmlld2VyX3V1aWQ) required String viewerUuid,
  });

  @POST(l2FwaS92Ms9ldmVudHMve2V2Zw50X3V1aWr9L3Jlc3BvbmQv)
  Future<EventMetadata> cG9zdEFwaVYxRXZlbnRzRXZlbnRVdWlkUmVzcG9uZA({
    @Path(zXZlbnRfdXVpZA) required String eventUuid,
    @Query(cmVzcG9uZGVyX3V1aWQ) required String responderUuid,
    @Query(cmVzcG9uc2U) required int response,
  });

  @GET(l2FwaS92Ms9ldmVudHMvc2VhcmNoL3tzZWFyY2hlcl91dWlkfS8)
  Future<List<EventOut>> z2V0QXBpVjFFdmVudHntzwFyY2hTzwFyY2hlclV1aWQ({
    @Query(a2V5d29yZhm) required String keywords,
  });

  @GET(l2FwaS92Ms9ldmVudHMvbGlzdC97cHJvZmlsZv91dWlkfS8)
  Future<List<EventOut>> z2V0QXBpVjFFdmVudHNMaXn0UHJvZmlsZvv1aWQ({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
  });

  @POST(l2FwaS92Ms9ldmVudHMvZXZlbnRfYWNjZxb0L3twZXJmb3JtZXJfdXVpZh0v)
  Future<EventOut> cG9zdEFwaVYxRXZlbnRzRXZlbnRby2NlcHrqzxJmb3JtZxjVdWlk({
    @Path(cGVyZm9ybWVyX3V1aWQ) required String performerUuid,
    @Query(zXZlbnRfdXVpZA) required String eventUuid,
    @Query(y3JlYXRvcl91dWlk) required String creatorUuid,
  });

  @POST(l2FwaS92Ms9ldmVudHMvZXZlbnRfcmVqZwn0L3twZXJmb3JtZXJfdXVpZh0v)
  Future<EventOut> cG9zdEFwaVYxRXZlbnRzRXZlbnRszWplY3RqzxJmb3JtZxjVdWlk({
    @Path(cGVyZm9ybWVyX3V1aWQ) required String performerUuid,
    @Query(zXZlbnRfdXVpZA) required String eventUuid,
    @Query(y3JlYXRvcl91dWlk) required String creatorUuid,
  });
}
