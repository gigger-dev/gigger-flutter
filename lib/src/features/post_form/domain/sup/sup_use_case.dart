// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../../models/paginated_response_profile_fewer_details_out.dart';
import '../../../../../models/simple_response.dart';
import '../../../../../models/sup_create.dart';
import '../../../../../models/sup_created_from_enum.dart';
import '../../../../../models/sup_metadata.dart';
import '../../../../../models/sup_out.dart';

import 'sup_repo.dart';

Future<SupOut> postApiV1SupUseCase({
  required SupCreate body,
  required U3VwUmVwbw repo,
}) {
  return repo.cG9zdEFwaVYxU3Vw(
    body: body,
  );
}

Future<PaginatedResponseProfileFewerDetailsOut> getApiV1SupUseCase({
  SupCreatedFromEnum createdFrom = SupCreatedFromEnum.none,
  int limit = 100,
  int offset = 0,
  required U3VwUmVwbw repo,
}) {
  return repo.z2V0QXBpVjFTdXA(
    createdFrom: createdFrom,
    limit: limit,
    offset: offset,
  );
}

Future<List<SupOut>> getApiV1SupProfileUuidUseCase({
  required String profileUuid,
  required SupCreatedFromEnum createdFrom,
  required U3VwUmVwbw repo,
}) {
  return repo.z2V0QXBpVjFTdXBQcm9maWxlVXVpZA(
    profileUuid: profileUuid,
    createdFrom: createdFrom,
  );
}

Future<SimpleResponse> deleteApiV1SupSupUuidUseCase({
  required String supUuid,
  required U3VwUmVwbw repo,
}) {
  return repo.zGVsZXRlQXBpVjFTdXBTdXBVdWlk(
    supUuid: supUuid,
  );
}

Future<SupMetadata> postApiV1SupSupUuidLikeUseCase({
  required String supUuid,
  required String likerUuid,
  required U3VwUmVwbw repo,
}) {
  return repo.cG9zdEFwaVYxU3VwU3VwVXVpZExpa2U(
    supUuid: supUuid,
    likerUuid: likerUuid,
  );
}

Future<SupMetadata> getApiV1SupSupUuidMetadataUseCase({
  required String supUuid,
  required String viewerUuid,
  required U3VwUmVwbw repo,
}) {
  return repo.z2V0QXBpVjFTdXBTdXBVdWlkTwv0YWRhdGE(
    supUuid: supUuid,
    viewerUuid: viewerUuid,
  );
}

Future<SupMetadata> postApiV1SupSupUuidShareUseCase({
  required String supUuid,
  required String sharerUuid,
  required U3VwUmVwbw repo,
}) {
  return repo.cG9zdEFwaVyxu3VwU3VwVXVpZFNoYXJl(
    supUuid: supUuid,
    sharerUuid: sharerUuid,
  );
}

Future<SupOut> getApiV1SupSupUuidGetUseCase({
  required String supUuid,
  required U3VwUmVwbw repo,
}) {
  return repo.z2V0QXBpVjFTdXBTdXBVdWlkR2V0(
    supUuid: supUuid,
  );
}

Future<SupMetadata> postApiV1SupSupUuidViewUseCase({
  required String supUuid,
  required String viewerUuid,
  required U3VwUmVwbw repo,
}) {
  return repo.cG9zdEFwaVYxU3VwU3VwVXVpZFZpZXc(
    supUuid: supUuid,
    viewerUuid: viewerUuid,
  );
}
