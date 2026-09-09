// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:mobile_gigger_app/gen/c_g9zd_h_nf_y2xp_zw50.dart';

import '../../../../../models/all_search_results.dart';
import '../../../../../models/hash_tag.dart';
import '../../../../../models/paginated_response_post_out.dart';
import '../../../../../models/post_create.dart';
import '../../../../../models/post_metadata.dart';
import '../../../../../models/post_out.dart';
import '../../../../../models/post_position_metadata.dart';
import '../../../../../models/post_update.dart';
import '../../../../../models/simple_response.dart';

import '../../domain/posts/posts_repo.dart';

class UG9zdHNSZXBvSW1wbA implements UG9zdHNSZXBv {
  UG9zdHNSZXBvSW1wbA(this.client);

  final UG9zdHNDbGllbnQ client;

  @override
  Future<PostOut> cG9zdEFwaVYxUg9zdHM({
    required PostCreate body,
  }) {
    return client.cG9zdEFwaVYxUg9zdHM(
      body: body,
    );
  }

  @override
  Future<List<HashTag>> z2V0QXBpVjFQb3N0c0hhc2h0YWdz({
    required String query,
  }) {
    return client.z2V0QXBpVjFQb3N0c0hhc2h0YWdz(
      query: query,
    );
  }

  @override
  Future<PaginatedResponsePostOut> z2V0QXBpVjFQb3N0c0ZhYg({
    required String profileUuid,
  }) {
    return client.z2V0QXBpVjFQb3N0c0ZhYg(
      profileUuid: profileUuid,
    );
  }

  @override
  Future<List<PostOut>> z2V0QXBpVjFQb3N0c1Byb2ZpbGVVdWlkRmFi({
    required String profileUuid,
  }) {
    return client.z2V0QXBpVjFQb3N0c1Byb2ZpbGVVdWlkRmFi(
      profileUuid: profileUuid,
    );
  }

  @override
  Future<SimpleResponse> zGVsZXRlQXBpVjFQb3N0c1Bvc3RVdWlk({
    required String postUuid,
  }) {
    return client.zGVsZXRlQXBpVjFQb3N0c1Bvc3RVdWlk(
      postUuid: postUuid,
    );
  }

  @override
  Future<PostOut> cGf0Y2hBcGlWmvBvc3RzUg9zdFv1aWQ({
    required String postUuid,
    required PostUpdate body,
  }) {
    return client.cGf0Y2hBcGlWmvBvc3RzUg9zdFv1aWQ(
      postUuid: postUuid,
      body: body,
    );
  }

  @override
  Future<PaginatedResponsePostOut> z2V0QXBpVjFQb3N0c1JlY29tbWVuZGVkUg9zdA({
    int limit = 100,
    int offset = 0,
  }) {
    return client.z2V0QXBpVjFQb3N0c1JlY29tbWVuZGVkUg9zdA(
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<PostPositionMetadata> cG9zdEFwaVYxUg9zdHnmyXlvdXQ({
    required PostPositionMetadata body,
  }) {
    return client.cG9zdEFwaVYxUg9zdHnmyXlvdXQ(
      body: body,
    );
  }

  @override
  Future<PostPositionMetadata> z2V0QXBpVjFQb3N0c0xheW91dA({
    required String profileUuid,
  }) {
    return client.z2V0QXBpVjFQb3N0c0xheW91dA(
      profileUuid: profileUuid,
    );
  }

  @override
  Future<PostMetadata> z2V0QXBpVjFQb3N0c1Bvc3RVdWlkTwv0YWRhdGE({
    required String postUuid,
    required String viewerUuid,
  }) {
    return client.z2V0QXBpVjFQb3N0c1Bvc3RVdWlkTwv0YWRhdGE(
      postUuid: postUuid,
      viewerUuid: viewerUuid,
    );
  }

  @override
  Future<PostMetadata> cG9zdEFwaVYxUg9zdHNQb3N0VXVpZFZpZXc({
    required String postUuid,
    required String viewerUuid,
  }) {
    return client.cG9zdEFwaVYxUg9zdHNQb3N0VXVpZFZpZXc(
      postUuid: postUuid,
      viewerUuid: viewerUuid,
    );
  }

  @override
  Future<PostOut> z2V0QXBpVjFQb3N0c1Bvc3RVdWlkR2V0({
    required String postUuid,
  }) {
    return client.z2V0QXBpVjFQb3N0c1Bvc3RVdWlkR2V0(
      postUuid: postUuid,
    );
  }

  @override
  Future<PostMetadata> cG9zdEFwaVYxUg9zdHNQb3N0VXVpZExpa2U({
    required String postUuid,
    required String likerUuid,
  }) {
    return client.cG9zdEFwaVYxUg9zdHNQb3N0VXVpZExpa2U(
      postUuid: postUuid,
      likerUuid: likerUuid,
    );
  }

  @override
  Future<PaginatedResponsePostOut> z2V0QXBpVjFQb3N0c1NlYXJjaGVyVXVpZFNlYXJjaA({
    required String searcherUuid,
    required String title,
    required String keywords,
    required String genre,
    int limit = 50,
    int offset = 0,
  }) {
    return client.z2V0QXBpVjFQb3N0c1NlYXJjaGVyVXVpZFNlYXJjaA(
      searcherUuid: searcherUuid,
      title: title,
      keywords: keywords,
      genre: genre,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<AllSearchResults> z2V0QXBpVjFQb3N0c1NlYXJjaGVyVXVpZFNlYXJjaEFsbA({
    required String searcherUuid,
    required String keywords,
  }) {
    return client.z2V0QXBpVjFQb3N0c1NlYXJjaGVyVXVpZFNlYXJjaEFsbA(
      searcherUuid: searcherUuid,
      keywords: keywords,
    );
  }

  @override
  Future<List<PostOut>> z2V0QXBpVjFQb3N0c1Byb2ZpbGVVdWlkUg9zdHM({
    required String profileUuid,
  }) {
    return client.z2V0QXBpVjFQb3N0c1Byb2ZpbGVVdWlkUg9zdHM(
      profileUuid: profileUuid,
    );
  }
}
