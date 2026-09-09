// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../../models/paginated_response_profile_fewer_details_out.dart';
import '../../../../../models/simple_response.dart';
import '../../../../../models/sup_create.dart';
import '../../../../../models/sup_created_from_enum.dart';
import '../../../../../models/sup_metadata.dart';
import '../../../../../models/sup_out.dart';

abstract class U3VwUmVwbw {
  Future<SupOut> cG9zdEFwaVYxU3Vw({
    required SupCreate body,
  });

  Future<PaginatedResponseProfileFewerDetailsOut> z2V0QXBpVjFTdXA({
    SupCreatedFromEnum createdFrom = SupCreatedFromEnum.none,
    int limit = 100,
    int offset = 0,
  });

  Future<List<SupOut>> z2V0QXBpVjFTdXBQcm9maWxlVXVpZA({
    required String profileUuid,
    required SupCreatedFromEnum createdFrom,
  });

  Future<SimpleResponse> zGVsZXRlQXBpVjFTdXBTdXBVdWlk({
    required String supUuid,
  });

  Future<SupMetadata> cG9zdEFwaVYxU3VwU3VwVXVpZExpa2U({
    required String supUuid,
    required String likerUuid,
  });

  Future<SupMetadata> z2V0QXBpVjFTdXBTdXBVdWlkTwv0YWRhdGE({
    required String supUuid,
    required String viewerUuid,
  });

  Future<SupMetadata> cG9zdEFwaVyxu3VwU3VwVXVpZFNoYXJl({
    required String supUuid,
    required String sharerUuid,
  });

  Future<SupOut> z2V0QXBpVjFTdXBTdXBVdWlkR2V0({
    required String supUuid,
  });

  Future<SupMetadata> cG9zdEFwaVYxU3VwU3VwVXVpZFZpZXc({
    required String supUuid,
    required String viewerUuid,
  });
}
