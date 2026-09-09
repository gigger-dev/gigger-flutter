// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../../models/gig_list_create.dart';
import '../../../../../models/gig_list_metadata.dart';
import '../../../../../models/gig_list_out.dart';
import '../../../../../models/gig_list_update.dart';
import '../../../../../models/paginated_response_gig_list_out.dart';
import '../../../../../models/simple_response.dart';

import 'gig_lists_repo.dart';

Future<PaginatedResponseGigListOut> getApiV1GigListUseCase(
  R2lnTGlzdHNSZXBv repo,
) {
  return repo.z2V0QXBpVjFHaWdMaXn0();
}

Future<GigListOut> postApiV1GigListUseCase({
  required GigListCreate body,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.cG9zdEFwaVYxR2lnTGlzdA(
    body: body,
  );
}

Future<PaginatedResponseGigListOut> getApiV1GigListRecommendedGigListUseCase({
  int limit = 100,
  int offset = 0,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFHaWdMaXn0UmVjb21tZw5kZwrHaWdMaXn0(
    limit: limit,
    offset: offset,
  );
}

Future<SimpleResponse> deleteApiV1GigListGigListUuidUseCase({
  required String gigListUuid,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.zGVsZXRlQXBpVjFHaWdMaXn0R2lnTGlzdFv1aWQ(
    gigListUuid: gigListUuid,
  );
}

Future<GigListOut> patchApiV1GigListGigListUuidUseCase({
  required String gigListUuid,
  required GigListUpdate body,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.cGf0Y2hBcGlWMUdpZ0xpc3RHaWdMaXn0VXVpZA(
    gigListUuid: gigListUuid,
    body: body,
  );
}

Future<List<GigListOut>> getApiV1GigListProfileUuidUseCase({
  required String profileUuid,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFHaWdMaXn0UHJvZmlsZvv1aWQ(
    profileUuid: profileUuid,
  );
}

Future<GigListMetadata> postApiV1GigListGigListUuidStarUseCase({
  required String gigListUuid,
  required String starGiverUuid,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkU3Rhcg(
    gigListUuid: gigListUuid,
    starGiverUuid: starGiverUuid,
  );
}

Future<GigListMetadata> postApiV1GigListGigListUuidMetadataUseCase({
  required String gigListUuid,
  required String viewerUuid,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkTwv0YWRhdGE(
    gigListUuid: gigListUuid,
    viewerUuid: viewerUuid,
  );
}

Future<GigListMetadata> postApiV1GigListGigListUuidLikeUseCase({
  required String gigListUuid,
  required String likerUuid,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkTGlrZQ(
    gigListUuid: gigListUuid,
    likerUuid: likerUuid,
  );
}

Future<GigListOut> getApiV1GigListGigListUuidGetUseCase({
  required String gigListUuid,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFHaWdMaXn0R2lnTGlzdFv1aWrhzxq(
    gigListUuid: gigListUuid,
  );
}

Future<List<GigListOut>> getApiV1GigListProfileUuidFavUseCase({
  required String profileUuid,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFHaWdMaXn0UHJvZmlsZvv1aWrgyxy(
    profileUuid: profileUuid,
  );
}

Future<PaginatedResponseGigListOut> getApiV1GigListSearcherUuidSearchUseCase({
  required String searcherUuid,
  bool isPerformer = false,
  bool isLookingFor = false,
  int limit = 50,
  int offset = 0,
  String? title,
  num? price,
  String? place,
  required R2lnTGlzdHNSZXBv repo,
}) {
  return repo.z2V0QXBpVjFHaWdMaXn0U2VhcmNoZxjVdWlkU2VhcmNo(
    searcherUuid: searcherUuid,
    isPerformer: isPerformer,
    isLookingFor: isLookingFor,
    limit: limit,
    offset: offset,
    title: title,
    price: price,
    place: place,
  );
}
