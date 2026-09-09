// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../models/gig_list_create.dart';
import '../../../../../models/gig_list_metadata.dart';
import '../../../../../models/gig_list_out.dart';
import '../../../../../models/gig_list_update.dart';
import '../../../../../models/paginated_response_gig_list_out.dart';
import '../../../../../models/simple_response.dart';

part 'z2ln_x2xpc3_rz_x2_nsa_w_vud_a.g.dart';

const String l2FwaS92Ms9naWctbGlzdC8 = '/api/v1/gig-list/';
const String l2FwaS92Ms9naWctbGlzdC9yZWNvbW1lbmRlZc1naWctbGlzdC8 =
    '/api/v1/gig-list/recommended-gig-list/';
const String l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0v =
    '/api/v1/gig-list/{gig_list_uuid}/';
const String l2FwaS92Ms9naWctbGlzdC97cHJvZmlsZv91dWlkfS8 =
    '/api/v1/gig-list/{profile_uuid}/';
const String l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0vc3Rhci8 =
    '/api/v1/gig-list/{gig_list_uuid}/star/';
const String l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0vbWv0YWRhdGEv =
    '/api/v1/gig-list/{gig_list_uuid}/metadata/';
const String l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0vbGlrZs8 =
    '/api/v1/gig-list/{gig_list_uuid}/like/';
const String l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0vZ2V0Lw =
    '/api/v1/gig-list/{gig_list_uuid}/get/';
const String l2FwaS92Ms9naWctbGlzdHtwcm9maWxlX3V1aWr9L2Zhdi8 =
    '/api/v1/gig-list{profile_uuid}/fav/';
const String l2FwaS92Ms9naWctbGlzdC97c2VhcmNoZXJfdXVpZh0vc2VhcmNoLw =
    '/api/v1/gig-list/{searcher_uuid}/search/';

const String bGltaXQ = 'limit';
const String b2Zmc2V0 = 'offset';
const String z2lnX2xpc3RfdXVpZA = 'gig_list_uuid';
const String cHJvZmlsZv91dWlk = 'profile_uuid';
const String c3Rhcl9naXZlcl91dWlk = 'star_giver_uuid';
const String dmlld2VyX3V1aWQ = 'viewer_uuid';
const String bGlrZXJfdXVpZA = 'liker_uuid';
const String c2VhcmNoZXJfdXVpZA = 'searcher_uuid';
const String dGl0bGU = 'title';
const String cHJpY2U = 'price';
const String cGxhY2U = 'place';
const String aXNfcGVyZm9ybWVy = 'is_performer';
const String aXNfbG9va2luZ19mb3I = 'is_looking_for';

@RestApi()
abstract class R2lnTGlzdHNDbGllbnQ {
  factory R2lnTGlzdHNDbGllbnQ(Dio dio, {String? baseUrl}) =
      _R2lnTGlzdHNDbGllbnQ;

  @GET(l2FwaS92Ms9naWctbGlzdC8)
  Future<PaginatedResponseGigListOut> z2V0QXBpVjFHaWdMaXn0();

  @POST(l2FwaS92Ms9naWctbGlzdC8)
  Future<GigListOut> cG9zdEFwaVYxR2lnTGlzdA({
    @Body() required GigListCreate body,
  });

  @GET(l2FwaS92Ms9naWctbGlzdC9yZWNvbW1lbmRlZc1naWctbGlzdC8)
  Future<PaginatedResponseGigListOut>
      z2V0QXBpVjFHaWdMaXn0UmVjb21tZw5kZwrHaWdMaXn0({
    @Query(bGltaXQ) int limit = 100,
    @Query(b2Zmc2V0) int offset = 0,
  });

  @DELETE(l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0v)
  Future<SimpleResponse> zGVsZXRlQXBpVjFHaWdMaXn0R2lnTGlzdFv1aWQ({
    @Path(z2lnX2xpc3RfdXVpZA) required String gigListUuid,
  });

  @PATCH(l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0v)
  Future<GigListOut> cGf0Y2hBcGlWMUdpZ0xpc3RHaWdMaXn0VXVpZA({
    @Path(z2lnX2xpc3RfdXVpZA) required String gigListUuid,
    @Body() required GigListUpdate body,
  });

  @GET(l2FwaS92Ms9naWctbGlzdC97cHJvZmlsZv91dWlkfS8)
  Future<List<GigListOut>> z2V0QXBpVjFHaWdMaXn0UHJvZmlsZvv1aWQ({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
  });

  @POST(l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0vc3Rhci8)
  Future<GigListMetadata> cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkU3Rhcg({
    @Path(z2lnX2xpc3RfdXVpZA) required String gigListUuid,
    @Query(c3Rhcl9naXZlcl91dWlk) required String starGiverUuid,
  });

  @POST(l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0vbWv0YWRhdGEv)
  Future<GigListMetadata> cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkTwv0YWRhdGE({
    @Path(z2lnX2xpc3RfdXVpZA) required String gigListUuid,
    @Query(dmlld2VyX3V1aWQ) required String viewerUuid,
  });

  @POST(l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0vbGlrZs8)
  Future<GigListMetadata> cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkTGlrZQ({
    @Path(z2lnX2xpc3RfdXVpZA) required String gigListUuid,
    @Query(bGlrZXJfdXVpZA) required String likerUuid,
  });

  @GET(l2FwaS92Ms9naWctbGlzdC97Z2lnX2xpc3RfdXVpZh0vZ2V0Lw)
  Future<GigListOut> z2V0QXBpVjFHaWdMaXn0R2lnTGlzdFv1aWrhzxq({
    @Path(z2lnX2xpc3RfdXVpZA) required String gigListUuid,
  });

  @GET(l2FwaS92Ms9naWctbGlzdHtwcm9maWxlX3V1aWr9L2Zhdi8)
  Future<List<GigListOut>> z2V0QXBpVjFHaWdMaXn0UHJvZmlsZvv1aWrgyxy({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
  });

  @GET(l2FwaS92Ms9naWctbGlzdC97c2VhcmNoZXJfdXVpZh0vc2VhcmNoLw)
  Future<PaginatedResponseGigListOut>
      z2V0QXBpVjFHaWdMaXn0U2VhcmNoZxjVdWlkU2VhcmNo({
    @Path(c2VhcmNoZXJfdXVpZA) required String searcherUuid,
    @Query(aXNfcGVyZm9ybWVy) bool isPerformer = false,
    @Query(aXNfbG9va2luZ19mb3I) bool isLookingFor = false,
    @Query(bGltaXQ) int limit = 50,
    @Query(b2Zmc2V0) int offset = 0,
    @Query(dGl0bGU) String? title,
    @Query(cHJpY2U) num? price,
    @Query(cGxhY2U) String? place,
  });
}
