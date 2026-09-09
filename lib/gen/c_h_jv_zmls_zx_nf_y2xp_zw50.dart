// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../models/interest_out.dart';
import '../../../../models/my_services_out.dart';
import '../../../../models/paginated_response_profile_fewer_details_out.dart';
import '../../../../models/paginated_response_profile_out.dart';
import '../../../../models/profile_fewer_details_out.dart';
import '../../../../models/profile_in.dart';
import '../../../../models/profile_meta_data_out.dart';
import '../../../../models/profile_out.dart';
import '../../../../models/profile_update.dart';
import '../../../../models/simple_response.dart';
import '../../../../models/skill_out.dart';

part 'c_h_jv_zmls_zx_nf_y2xp_zw50.g.dart';

const String l2FwaS92Ms9wcm9maWxlcy9pbnRlcmVzdHM = '/api/v1/profiles/interests';
const String l2FwaS92Ms9wcm9maWxlcy9zZxj2aWNlcw = '/api/v1/profiles/services';
const String l2FwaS92Ms9wcm9maWxlcy9za2lsbHM = '/api/v1/profiles/skills';
const String l2FwaS92Ms9wcm9maWxlcy8 = '/api/v1/profiles/';
const String l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfQ =
    '/api/v1/profiles/{profile_uuid}';
const String
    l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9yZWNvbW1lbmRlZc1hcnRpc3Qv =
    '/api/v1/profiles/{profile_uuid}/recommended-artist/';
const String l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS8 =
    '/api/v1/profiles/{profile_uuid}/';
const String l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9tZXRhZgf0Ys8 =
    '/api/v1/profiles/{profile_uuid}/metadata/';
const String l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9mb2xsb3dlcnMv =
    '/api/v1/profiles/{profile_uuid}/followers/';
const String
    l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9mb2xsb3dlcnMvc2VhcmNoLw =
    '/api/v1/profiles/{profile_uuid}/followers/search/';
const String l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9mb2xsb3dpbmcv =
    '/api/v1/profiles/{profile_uuid}/following/';
const String
    l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9mb2xsb3ctYw5vdGhlci1wcm9maWxlLw =
    '/api/v1/profiles/{profile_uuid}/follow-another-profile/';
const String
    l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS91bmZvbGxvdy1hbm90aGVyLXByb2ZpbGUv =
    '/api/v1/profiles/{profile_uuid}/unfollow-another-profile/';
const String
    l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9yZw1vdmUtbXktZm9sbG93ZXIv =
    '/api/v1/profiles/{profile_uuid}/remove-my-follower/';
const String
    l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9yZxf1Zxn0LXRvLWZvbGxvdy1wcml2YXRlLXByb2ZpbGUv =
    '/api/v1/profiles/{profile_uuid}/request-to-follow-private-profile/';
const String
    l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9hY2NlcHQtb3ItcmVqZwn0LWZvbGxvdy1yZxf1Zxn0LW =
    '/api/v1/profiles/{profile_uuid}/accept-or-reject-follow-request/';
const String
    l2FwaS92Ms9wcm9maWxlcy97Y2FuY2VsZxj9L2NhbmNlbC1yZxf1Zxn0LXRvLWZvbGxvdy8 =
    '/api/v1/profiles/{canceler}/cancel-request-to-follow/';
const String
    l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS90b2dnbGUtcHJpdmF0Zs1wcm9maWxlLw1vZGUv =
    '/api/v1/profiles/{profile_uuid}/toggle-private-profile-mode/';
const String l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS92aWv3Lw =
    '/api/v1/profiles/{profile_uuid}/view/';
const String l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9zZWFyY2gv =
    '/api/v1/profiles/{profile_uuid}/search/';

const String cXVlcnk = 'query';
const String yWNjb3VudF91dWlk = 'account_uuid';
const String cHJvZmlsZv91dWlk = 'profile_uuid';
const String bGltaXQ = 'limit';
const String b2Zmc2V0 = 'offset';
const String dXNlcm5hbWU = 'username';
const String cHJvZmlsZv90b19mb2xsb3c = 'profile_to_follow';
const String cHJvZmlsZv90b191bmZvbGxvdw = 'profile_to_unfollow';
const String cHJvZmlsZv90b19yZw1vdmU = 'profile_to_remove';
const String cHJvZmlsZv90b19yZxf1Zxn0X3RvX2ZvbGxvdw =
    'profile_to_request_to_follow';
const String cHJvZmlsZv90b19hY2NlcHRfb3JfcmVqZwn0 =
    'profile_to_accept_or_reject';
const String aXNfYWNjZxb0Zwq = 'is_accepted';
const String y2FuY2VsZxi = 'canceler';
const String cHJvZmlsZv90b19jYw5jZWxfZm9sbG93X3JlcXVlc3Q =
    'profile_to_cancel_follow_request';
const String aXNfcHJpdmF0ZQ = 'is_private';
const String dmlld2VyX3V1aWQ = 'viewer_uuid';
const String cm9sZQ = 'role';
const String z2VucmU = 'genre';
const String aW5zdHj1bWVudA = 'instrument';
const String c3RhcnRfZgf0ZQ = 'start_date';
const String zw5kX2RhdGU = 'end_date';
const String cHJvX3VzZXJfb25seQ = 'pro_user_only';

@RestApi()
abstract class UHJvZmlsZXNDbGllbnQ {
  factory UHJvZmlsZXNDbGllbnQ(Dio dio, {String? baseUrl}) =
      _UHJvZmlsZXNDbGllbnQ;

  @GET(l2FwaS92Ms9wcm9maWxlcy9pbnRlcmVzdHM)
  Future<List<InterestOut>> z2V0QXBpVjFQcm9maWxlc0ludGVyZxn0cw({
    @Query(cXVlcnk) String? query,
  });

  @GET(l2FwaS92Ms9wcm9maWxlcy9zZxj2aWNlcw)
  Future<List<MyServicesOut>> z2V0QXBpVjFQcm9maWxlc1NlcnZpY2Vz({
    @Query(cXVlcnk) String? query,
  });

  @GET(l2FwaS92Ms9wcm9maWxlcy9za2lsbHM)
  Future<List<SkillOut>> z2V0QXBpVjFQcm9maWxlc1NraWxscw({
    @Query(cXVlcnk) String? query,
  });

  @GET(l2FwaS92Ms9wcm9maWxlcy8)
  Future<ProfileOut> z2V0QXBpVjFQcm9maWxlcw({
    @Query(yWNjb3VudF91dWlk) required String accountUuid,
  });

  @POST(l2FwaS92Ms9wcm9maWxlcy8)
  Future<ProfileOut> cG9zdEFwaVYxUHJvZmlsZxm({
    @Body() required ProfileIn body,
  });

  @PATCH(l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfQ)
  Future<ProfileOut> cGf0Y2hBcGlWmvByb2ZpbGVzUHJvZmlsZvv1aWQ({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Body() required ProfileUpdate body,
  });

  @GET(l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9yZWNvbW1lbmRlZc1hcnRpc3Qv)
  Future<PaginatedResponseProfileOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkUmVjb21tZw5kZwrBcnRpc3Q({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(bGltaXQ) int limit = 100,
    @Query(b2Zmc2V0) int offset = 0,
  });

  @GET(l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS8)
  Future<ProfileOut> z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlk({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
  });

  @GET(l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9tZXRhZgf0Ys8)
  Future<ProfileMetaDataOut> z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkTwv0YWRhdGE({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
  });

  @GET(l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9mb2xsb3dlcnMv)
  Future<PaginatedResponseProfileFewerDetailsOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93ZXJz({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(bGltaXQ) int limit = 100,
    @Query(b2Zmc2V0) int offset = 0,
  });

  @GET(l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9mb2xsb3dlcnMvc2VhcmNoLw)
  Future<List<ProfileFewerDetailsOut>>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93ZXJzU2VhcmNo({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(dXNlcm5hbWU) required String username,
  });

  @GET(l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9mb2xsb3dpbmcv)
  Future<PaginatedResponseProfileFewerDetailsOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93aW5n({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(bGltaXQ) int limit = 100,
    @Query(b2Zmc2V0) int offset = 0,
  });

  @POST(
      l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9mb2xsb3ctYw5vdGhlci1wcm9maWxlLw)
  Future<SimpleResponse>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZEZvbGxvd0Fub3RoZxjQcm9maWxl({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(cHJvZmlsZv90b19mb2xsb3c) required String profileToFollow,
  });

  @DELETE(
      l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS91bmZvbGxvdy1hbm90aGVyLXByb2ZpbGUv)
  Future<SimpleResponse>
      zGVsZXRlQXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkVw5mb2xsb3dBbm90aGVyUHJvZmlsZQ({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(cHJvZmlsZv90b191bmZvbGxvdw) required String profileToUnfollow,
  });

  @DELETE(l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9yZw1vdmUtbXktZm9sbG93ZXIv)
  Future<SimpleResponse>
      zGVsZXRlQXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkUmVtb3ZlTXlGb2xsb3dlcg({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(cHJvZmlsZv90b19yZw1vdmU) required String profileToRemove,
  });

  @POST(
      l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9yZxf1Zxn0LXRvLWZvbGxvdy1wcml2YXRlLXByb2ZpbGUv)
  Future<SimpleResponse>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFJlcXVlc3RUb0ZvbGxvd1ByaXZhdGVQcm9maWxl({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(cHJvZmlsZv90b19yZxf1Zxn0X3RvX2ZvbGxvdw)
    required String profileToRequestToFollow,
  });

  @POST(
      l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9hY2NlcHQtb3ItcmVqZwn0LWZvbGxvdy1yZxf1Zxn0LW)
  Future<SimpleResponse>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZEFjY2VwdE9yUmVqZwn0Rm9sbG93UmVxdWVzdA({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(cHJvZmlsZv90b19hY2NlcHRfb3JfcmVqZwn0)
    required String profileToAcceptOrReject,
    @Query(aXNfYWNjZxb0Zwq) required bool isAccepted,
  });

  @POST(l2FwaS92Ms9wcm9maWxlcy97Y2FuY2VsZxj9L2NhbmNlbC1yZxf1Zxn0LXRvLWZvbGxvdy8)
  Future<void> cG9zdEFwaVYxUHJvZmlsZxndyw5jZWxlckNhbmNlbFJlcXVlc3RUb0ZvbGxvdw({
    @Path(y2FuY2VsZxi) required String canceler,
    @Query(cHJvZmlsZv90b19jYw5jZWxfZm9sbG93X3JlcXVlc3Q)
    required String profileToCancelFollowRequest,
  });

  @POST(
      l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS90b2dnbGUtcHJpdmF0Zs1wcm9maWxlLw1vZGUv)
  Future<ProfileOut>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFRvZ2dsZVByaXZhdGVQcm9maWxlTw9kZQ({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(aXNfcHJpdmF0ZQ) required bool isPrivate,
  });

  @POST(l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS92aWv3Lw)
  Future<ProfileMetaDataOut> cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFZpZXc({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(dmlld2VyX3V1aWQ) required String viewerUuid,
  });

  @GET(l2FwaS92Ms9wcm9maWxlcy97cHJvZmlsZv91dWlkfS9zZWFyY2gv)
  Future<PaginatedResponseProfileOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkU2VhcmNo({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
    @Query(bGltaXQ) int limit = 50,
    @Query(b2Zmc2V0) int offset = 0,
    @Query(cHJvX3VzZXJfb25seQ) bool proUserOnly = false,
    @Query(dXNlcm5hbWU) String? username,
    @Query(cm9sZQ) String? role,
    @Query(z2VucmU) String? genre,
    @Query(aW5zdHj1bWVudA) String? instrument,
    @Query(c3RhcnRfZgf0ZQ) DateTime? startDate,
    @Query(zw5kX2RhdGU) DateTime? endDate,
  });
}
