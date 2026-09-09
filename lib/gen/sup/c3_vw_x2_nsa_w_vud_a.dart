// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../models/paginated_response_profile_fewer_details_out.dart';
import '../../../../../models/simple_response.dart';
import '../../../../../models/sup_create.dart';
import '../../../../../models/sup_created_from_enum.dart';
import '../../../../../models/sup_metadata.dart';
import '../../../../../models/sup_out.dart';

part 'c3_vw_x2_nsa_w_vud_a.g.dart';

const String l2FwaS92Ms9zdXAv = '/api/v1/sup/';
const String l2FwaS92Ms9zdXAve3Byb2ZpbGVfdXVpZh0v =
    '/api/v1/sup/{profile_uuid}/';
const String l2FwaS92Ms9zdXAve3N1cF91dWlkfQ = '/api/v1/sup/{sup_uuid}';
const String l2FwaS92Ms9zdXAve3N1cF91dWlkfS9saWtlLw =
    '/api/v1/sup/{sup_uuid}/like/';
const String l2FwaS92Ms9zdXAve3N1cF91dWlkfS9tZXRhZgf0Ys8 =
    '/api/v1/sup/{sup_uuid}/metadata/';
const String l2FwaS92Ms9zdXAve3N1cF91dWlkfS9zaGFyZs8 =
    '/api/v1/sup/{sup_uuid}/share/';
const String l2FwaS92Ms9zdXAve3N1cF91dWlkfS9nZXQv =
    '/api/v1/sup/{sup_uuid}/get/';
const String l2FwaS92Ms9zdXAve3N1cF91dWlkfS92aWv3Lw =
    '/api/v1/sup/{sup_uuid}/view/';

const String y3JlYXRlZf9mcm9t = 'created_from';
const String bGltaXQ = 'limit';
const String b2Zmc2V0 = 'offset';
const String cHJvZmlsZv91dWlk = 'profile_uuid';
const String c3VwX3V1aWQ = 'sup_uuid';
const String bGlrZXJfdXVpZA = 'liker_uuid';
const String dmlld2VyX3V1aWQ = 'viewer_uuid';
const String c2hhcmVyX3V1aWQ = 'sharer_uuid';

@RestApi()
abstract class U3VwQ2xpZW50 {
  factory U3VwQ2xpZW50(Dio dio, {String? baseUrl}) = _U3VwQ2xpZW50;

  @POST(l2FwaS92Ms9zdXAv)
  Future<SupOut> cG9zdEFwaVYxU3Vw({
    @Body() required SupCreate body,
  });

  @GET(l2FwaS92Ms9zdXAv)
  Future<PaginatedResponseProfileFewerDetailsOut> z2V0QXBpVjFTdXA({
    @Query(y3JlYXRlZf9mcm9t)
    SupCreatedFromEnum createdFrom = SupCreatedFromEnum.none,
    @Query(bGltaXQ) int limit = 100,
    @Query(b2Zmc2V0) int offset = 0,
  });

  @GET(l2FwaS92Ms9zdXAve3Byb2ZpbGVfdXVpZh0v)
  Future<List<SupOut>> z2V0QXBpVjFTdXBQcm9maWxlVXVpZA({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(y3JlYXRlZf9mcm9t) required SupCreatedFromEnum createdFrom,
  });

  @DELETE(l2FwaS92Ms9zdXAve3N1cF91dWlkfQ)
  Future<SimpleResponse> zGVsZXRlQXBpVjFTdXBTdXBVdWlk({
    @Path(c3VwX3V1aWQ) required String supUuid,
  });

  @POST(l2FwaS92Ms9zdXAve3N1cF91dWlkfS9saWtlLw)
  Future<SupMetadata> cG9zdEFwaVYxU3VwU3VwVXVpZExpa2U({
    @Path(c3VwX3V1aWQ) required String supUuid,
    @Query(bGlrZXJfdXVpZA) required String likerUuid,
  });

  @GET(l2FwaS92Ms9zdXAve3N1cF91dWlkfS9tZXRhZgf0Ys8)
  Future<SupMetadata> z2V0QXBpVjFTdXBTdXBVdWlkTwv0YWRhdGE({
    @Path(c3VwX3V1aWQ) required String supUuid,
    @Query(dmlld2VyX3V1aWQ) required String viewerUuid,
  });

  @POST(l2FwaS92Ms9zdXAve3N1cF91dWlkfS9zaGFyZs8)
  Future<SupMetadata> cG9zdEFwaVyxu3VwU3VwVXVpZFNoYXJl({
    @Path(c3VwX3V1aWQ) required String supUuid,
    @Query(c2hhcmVyX3V1aWQ) required String sharerUuid,
  });

  @GET(l2FwaS92Ms9zdXAve3N1cF91dWlkfS9nZXQv)
  Future<SupOut> z2V0QXBpVjFTdXBTdXBVdWlkR2V0({
    @Path(c3VwX3V1aWQ) required String supUuid,
  });

  @POST(l2FwaS92Ms9zdXAve3N1cF91dWlkfS92aWv3Lw)
  Future<SupMetadata> cG9zdEFwaVYxU3VwU3VwVXVpZFZpZXc({
    @Path(c3VwX3V1aWQ) required String supUuid,
    @Query(dmlld2VyX3V1aWQ) required String viewerUuid,
  });
}
