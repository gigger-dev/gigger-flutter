// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../models/all_search_results.dart';
import '../../../../models/hash_tag.dart';
import '../../../../models/paginated_response_post_out.dart';
import '../../../../models/post_create.dart';
import '../../../../models/post_metadata.dart';
import '../../../../models/post_out.dart';
import '../../../../models/post_position_metadata.dart';
import '../../../../models/post_update.dart';
import '../../../../models/simple_response.dart';

import 'posts_repo.dart';

Future<PostOut> postApiV1PostsUseCase({
  required PostCreate body,
  required UG9zdHNSZXBv repo,
}) {
  return repo.cG9zdEFwaVYxUg9zdHM(
    body: body,
  );
}

Future<List<HashTag>> getApiV1PostsHashtagsUseCase({
  required String query,
  required UG9zdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFQb3N0c0hhc2h0YWdz(
    query: query,
  );
}

Future<PaginatedResponsePostOut> getApiV1PostsFabUseCase({
  required String profileUuid,
  required UG9zdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFQb3N0c0ZhYg(
    profileUuid: profileUuid,
  );
}

Future<List<PostOut>> getApiV1PostsProfileUuidFabUseCase({
  required String profileUuid,
  required UG9zdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFQb3N0c1Byb2ZpbGVVdWlkRmFi(
    profileUuid: profileUuid,
  );
}

Future<SimpleResponse> deleteApiV1PostsPostUuidUseCase({
  required String postUuid,
  required UG9zdHNSZXBv repo,
}) {
  return repo.zGVsZXRlQXBpVjFQb3N0c1Bvc3RVdWlk(
    postUuid: postUuid,
  );
}

Future<PostOut> patchApiV1PostsPostUuidUseCase({
  required String postUuid,
  required PostUpdate body,
  required UG9zdHNSZXBv repo,
}) {
  return repo.cGf0Y2hBcGlWmvBvc3RzUg9zdFv1aWQ(
    postUuid: postUuid,
    body: body,
  );
}

Future<PaginatedResponsePostOut> getApiV1PostsRecommendedPostUseCase({
  int limit = 100,
  int offset = 0,
  required UG9zdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFQb3N0c1JlY29tbWVuZGVkUg9zdA(
    limit: limit,
    offset: offset,
  );
}

Future<PostPositionMetadata> postApiV1PostsLayoutUseCase({
  required PostPositionMetadata body,
  required UG9zdHNSZXBv repo,
}) {
  return repo.cG9zdEFwaVYxUg9zdHnmyXlvdXQ(
    body: body,
  );
}

Future<PostPositionMetadata> getApiV1PostsLayoutUseCase({
  required String profileUuid,
  required UG9zdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFQb3N0c0xheW91dA(
    profileUuid: profileUuid,
  );
}

Future<PostMetadata> getApiV1PostsPostUuidMetadataUseCase({
  required String postUuid,
  required String viewerUuid,
  required UG9zdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFQb3N0c1Bvc3RVdWlkTwv0YWRhdGE(
    postUuid: postUuid,
    viewerUuid: viewerUuid,
  );
}

Future<PostMetadata> postApiV1PostsPostUuidViewUseCase({
  required String postUuid,
  required String viewerUuid,
  required UG9zdHNSZXBv repo,
}) {
  return repo.cG9zdEFwaVYxUg9zdHNQb3N0VXVpZFZpZXc(
    postUuid: postUuid,
    viewerUuid: viewerUuid,
  );
}

Future<PostOut> getApiV1PostsPostUuidGetUseCase({
  required String postUuid,
  required UG9zdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFQb3N0c1Bvc3RVdWlkR2V0(
    postUuid: postUuid,
  );
}

Future<PostMetadata> postApiV1PostsPostUuidLikeUseCase({
  required String postUuid,
  required String likerUuid,
  required UG9zdHNSZXBv repo,
}) {
  return repo.cG9zdEFwaVYxUg9zdHNQb3N0VXVpZExpa2U(
    postUuid: postUuid,
    likerUuid: likerUuid,
  );
}

Future<PaginatedResponsePostOut> getApiV1PostsSearcherUuidSearchUseCase({
  required String searcherUuid,
  required String title,
  required String keywords,
  required String genre,
  int limit = 50,
  int offset = 0,
  required UG9zdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFQb3N0c1NlYXJjaGVyVXVpZFNlYXJjaA(
    searcherUuid: searcherUuid,
    title: title,
    keywords: keywords,
    genre: genre,
    limit: limit,
    offset: offset,
  );
}

Future<AllSearchResults> getApiV1PostsSearcherUuidSearchAllUseCase({
  required String searcherUuid,
  required String keywords,
  required UG9zdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFQb3N0c1NlYXJjaGVyVXVpZFNlYXJjaEFsbA(
    searcherUuid: searcherUuid,
    keywords: keywords,
  );
}

Future<List<PostOut>> getApiV1PostsProfileUuidPostsUseCase({
  required String profileUuid,
  required UG9zdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFQb3N0c1Byb2ZpbGVVdWlkUg9zdHM(
    profileUuid: profileUuid,
  );
}
