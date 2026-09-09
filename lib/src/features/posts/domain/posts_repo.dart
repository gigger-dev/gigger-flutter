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

abstract class UG9zdHNSZXBv {
  Future<PostOut> cG9zdEFwaVYxUg9zdHM({
    required PostCreate body,
  });

  Future<List<HashTag>> z2V0QXBpVjFQb3N0c0hhc2h0YWdz({
    required String query,
  });

  Future<PaginatedResponsePostOut> z2V0QXBpVjFQb3N0c0ZhYg({
    required String profileUuid,
  });

  Future<List<PostOut>> z2V0QXBpVjFQb3N0c1Byb2ZpbGVVdWlkRmFi({
    required String profileUuid,
  });

  Future<SimpleResponse> zGVsZXRlQXBpVjFQb3N0c1Bvc3RVdWlk({
    required String postUuid,
  });

  Future<PostOut> cGf0Y2hBcGlWmvBvc3RzUg9zdFv1aWQ({
    required String postUuid,
    required PostUpdate body,
  });

  Future<PaginatedResponsePostOut> z2V0QXBpVjFQb3N0c1JlY29tbWVuZGVkUg9zdA({
    int limit = 100,
    int offset = 0,
  });

  Future<PostPositionMetadata> cG9zdEFwaVYxUg9zdHnmyXlvdXQ({
    required PostPositionMetadata body,
  });

  Future<PostPositionMetadata> z2V0QXBpVjFQb3N0c0xheW91dA({
    required String profileUuid,
  });

  Future<PostMetadata> z2V0QXBpVjFQb3N0c1Bvc3RVdWlkTwv0YWRhdGE({
    required String postUuid,
    required String viewerUuid,
  });

  Future<PostMetadata> cG9zdEFwaVYxUg9zdHNQb3N0VXVpZFZpZXc({
    required String postUuid,
    required String viewerUuid,
  });

  Future<PostOut> z2V0QXBpVjFQb3N0c1Bvc3RVdWlkR2V0({
    required String postUuid,
  });

  Future<PostMetadata> cG9zdEFwaVYxUg9zdHNQb3N0VXVpZExpa2U({
    required String postUuid,
    required String likerUuid,
  });

  Future<PaginatedResponsePostOut> z2V0QXBpVjFQb3N0c1NlYXJjaGVyVXVpZFNlYXJjaA({
    required String searcherUuid,
    required String title,
    required String keywords,
    required String genre,
    int limit = 50,
    int offset = 0,
  });

  Future<AllSearchResults> z2V0QXBpVjFQb3N0c1NlYXJjaGVyVXVpZFNlYXJjaEFsbA({
    required String searcherUuid,
    required String keywords,
  });

  Future<List<PostOut>> z2V0QXBpVjFQb3N0c1Byb2ZpbGVVdWlkUg9zdHM({
    required String profileUuid,
  });
}
