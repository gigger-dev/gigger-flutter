// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../models/all_search_results.dart';
import '../../../../models/hash_tag.dart';
import '../../../../models/paginated_response_post_out.dart';
import '../../../../models/post_create.dart';
import '../../../../models/post_metadata.dart';
import '../../../../models/post_out.dart';
import '../../../../models/post_position_metadata.dart';
import '../../../../models/post_update.dart';
import '../../../../models/simple_response.dart';

part 'c_g9zd_h_nf_y2xp_zw50.g.dart';

const String l2FwaS92Ms9wb3N0cy8 = '/api/v1/posts/';
const String l2FwaS92Ms9wb3N0cy9oYXNodGFncy8 = '/api/v1/posts/hashtags/';
const String l2FwaS92Ms9wb3N0cy9mYWIv = '/api/v1/posts/fab/';
const String l2FwaS92Ms9wb3N0cy97cHJvZmlsZv91dWlkfS9mYWIv =
    '/api/v1/posts/{profile_uuid}/fab/';
const String l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfQ = '/api/v1/posts/{post_uuid}';
const String l2FwaS92Ms9wb3N0cy9yZWNvbW1lbmRlZc1wb3N0Lw =
    '/api/v1/posts/recommended-post/';
const String l2FwaS92Ms9wb3N0cy9sYXlvdXQv = '/api/v1/posts/layout/';
const String l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfS9tZXRhZgf0Ys8 =
    '/api/v1/posts/{post_uuid}/metadata/';
const String l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfS92aWv3Lw =
    '/api/v1/posts/{post_uuid}/view/';
const String l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfS9nZXQv =
    '/api/v1/posts/{post_uuid}/get/';
const String l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfS9saWtlLw =
    '/api/v1/posts/{post_uuid}/like/';
const String l2FwaS92Ms9wb3N0cy97c2VhcmNoZXJfdXVpZh0vc2VhcmNo =
    '/api/v1/posts/{searcher_uuid}/search';
const String l2FwaS92Ms9wb3N0cy97c2VhcmNoZXJfdXVpZh0vc2VhcmNoL2FsbC8 =
    '/api/v1/posts/{searcher_uuid}/search/all/';
const String l2FwaS92Ms9wb3N0cy97cHJvZmlsZv91dWlkfS9wb3N0cy8 =
    '/api/v1/posts/{profile_uuid}/posts/';

const String cXVlcnk = 'query';
const String cHJvZmlsZv91dWlk = 'profile_uuid';
const String cG9zdF91dWlk = 'post_uuid';
const String bGltaXQ = 'limit';
const String b2Zmc2V0 = 'offset';
const String dmlld2VyX3V1aWQ = 'viewer_uuid';
const String bGlrZXJfdXVpZA = 'liker_uuid';
const String c2VhcmNoZXJfdXVpZA = 'searcher_uuid';
const String dGl0bGU = 'title';
const String a2V5d29yZhm = 'keywords';
const String z2VucmU = 'genre';

@RestApi()
abstract class UG9zdHNDbGllbnQ {
  factory UG9zdHNDbGllbnQ(Dio dio, {String? baseUrl}) = _UG9zdHNDbGllbnQ;

  @POST(l2FwaS92Ms9wb3N0cy8)
  Future<PostOut> cG9zdEFwaVYxUg9zdHM({
    @Body() required PostCreate body,
  });

  @GET(l2FwaS92Ms9wb3N0cy9oYXNodGFncy8)
  Future<List<HashTag>> z2V0QXBpVjFQb3N0c0hhc2h0YWdz({
    @Query(cXVlcnk) required String query,
  });

  @GET(l2FwaS92Ms9wb3N0cy9mYWIv)
  Future<PaginatedResponsePostOut> z2V0QXBpVjFQb3N0c0ZhYg({
    @Query(cHJvZmlsZv91dWlk) required String profileUuid,
  });

  @GET(l2FwaS92Ms9wb3N0cy97cHJvZmlsZv91dWlkfS9mYWIv)
  Future<List<PostOut>> z2V0QXBpVjFQb3N0c1Byb2ZpbGVVdWlkRmFi({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
  });

  @DELETE(l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfQ)
  Future<SimpleResponse> zGVsZXRlQXBpVjFQb3N0c1Bvc3RVdWlk({
    @Path(cG9zdF91dWlk) required String postUuid,
  });

  @PATCH(l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfQ)
  Future<PostOut> cGf0Y2hBcGlWmvBvc3RzUg9zdFv1aWQ({
    @Path(cG9zdF91dWlk) required String postUuid,
    @Body() required PostUpdate body,
  });

  @GET(l2FwaS92Ms9wb3N0cy9yZWNvbW1lbmRlZc1wb3N0Lw)
  Future<PaginatedResponsePostOut> z2V0QXBpVjFQb3N0c1JlY29tbWVuZGVkUg9zdA({
    @Query(bGltaXQ) int limit = 100,
    @Query(b2Zmc2V0) int offset = 0,
  });

  @POST(l2FwaS92Ms9wb3N0cy9sYXlvdXQv)
  Future<PostPositionMetadata> cG9zdEFwaVYxUg9zdHnmyXlvdXQ({
    @Body() required PostPositionMetadata body,
  });

  @GET(l2FwaS92Ms9wb3N0cy9sYXlvdXQv)
  Future<PostPositionMetadata> z2V0QXBpVjFQb3N0c0xheW91dA({
    @Query(cHJvZmlsZv91dWlk) required String profileUuid,
  });

  @GET(l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfS9tZXRhZgf0Ys8)
  Future<PostMetadata> z2V0QXBpVjFQb3N0c1Bvc3RVdWlkTwv0YWRhdGE({
    @Path(cG9zdF91dWlk) required String postUuid,
    @Query(dmlld2VyX3V1aWQ) required String viewerUuid,
  });

  @POST(l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfS92aWv3Lw)
  Future<PostMetadata> cG9zdEFwaVYxUg9zdHNQb3N0VXVpZFZpZXc({
    @Path(cG9zdF91dWlk) required String postUuid,
    @Query(dmlld2VyX3V1aWQ) required String viewerUuid,
  });

  @GET(l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfS9nZXQv)
  Future<PostOut> z2V0QXBpVjFQb3N0c1Bvc3RVdWlkR2V0({
    @Path(cG9zdF91dWlk) required String postUuid,
  });

  @POST(l2FwaS92Ms9wb3N0cy97cG9zdF91dWlkfS9saWtlLw)
  Future<PostMetadata> cG9zdEFwaVYxUg9zdHNQb3N0VXVpZExpa2U({
    @Path(cG9zdF91dWlk) required String postUuid,
    @Query(bGlrZXJfdXVpZA) required String likerUuid,
  });

  @GET(l2FwaS92Ms9wb3N0cy97c2VhcmNoZXJfdXVpZh0vc2VhcmNo)
  Future<PaginatedResponsePostOut> z2V0QXBpVjFQb3N0c1NlYXJjaGVyVXVpZFNlYXJjaA({
    @Path(c2VhcmNoZXJfdXVpZA) required String searcherUuid,
    @Query(dGl0bGU) required String title,
    @Query(a2V5d29yZhm) required String keywords,
    @Query(z2VucmU) required String genre,
    @Query(bGltaXQ) int limit = 50,
    @Query(b2Zmc2V0) int offset = 0,
  });

  @GET(l2FwaS92Ms9wb3N0cy97c2VhcmNoZXJfdXVpZh0vc2VhcmNoL2FsbC8)
  Future<AllSearchResults> z2V0QXBpVjFQb3N0c1NlYXJjaGVyVXVpZFNlYXJjaEFsbA({
    @Path(c2VhcmNoZXJfdXVpZA) required String searcherUuid,
    @Query(a2V5d29yZhm) required String keywords,
  });

  @GET(l2FwaS92Ms9wb3N0cy97cHJvZmlsZv91dWlkfS9wb3N0cy8)
  Future<List<PostOut>> z2V0QXBpVjFQb3N0c1Byb2ZpbGVVdWlkUg9zdHM({
    @Path(cHJvZmlsZv91dWlk) required String profileUuid,
  });
}
