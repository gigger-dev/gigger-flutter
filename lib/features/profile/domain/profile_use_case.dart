// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

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

import 'profile_repo.dart';

Future<List<InterestOut>> getApiV1ProfilesInterestsUseCase({
  String? query,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlc0ludGVyZxn0cw(
    query: query,
  );
}

Future<List<MyServicesOut>> getApiV1ProfilesServicesUseCase({
  String? query,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlc1NlcnZpY2Vz(
    query: query,
  );
}

Future<List<SkillOut>> getApiV1ProfilesSkillsUseCase({
  String? query,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlc1NraWxscw(
    query: query,
  );
}

Future<ProfileOut> getApiV1ProfilesUseCase({
  required String accountUuid,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlcw(
    accountUuid: accountUuid,
  );
}

Future<ProfileOut> postApiV1ProfilesUseCase({
  required ProfileIn body,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxUHJvZmlsZxm(
    body: body,
  );
}

Future<ProfileOut> patchApiV1ProfilesProfileUuidUseCase({
  required String profileUuid,
  required ProfileUpdate body,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.cGf0Y2hBcGlWmvByb2ZpbGVzUHJvZmlsZvv1aWQ(
    profileUuid: profileUuid,
    body: body,
  );
}

Future<PaginatedResponseProfileOut>
    getApiV1ProfilesProfileUuidRecommendedArtistUseCase({
  required String profileUuid,
  int limit = 100,
  int offset = 0,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkUmVjb21tZw5kZwrBcnRpc3Q(
    profileUuid: profileUuid,
    limit: limit,
    offset: offset,
  );
}

Future<ProfileOut> getApiV1ProfilesProfileUuidUseCase({
  required String profileUuid,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlk(
    profileUuid: profileUuid,
  );
}

Future<ProfileMetaDataOut> getApiV1ProfilesProfileUuidMetadataUseCase({
  required String profileUuid,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkTwv0YWRhdGE(
    profileUuid: profileUuid,
  );
}

Future<PaginatedResponseProfileFewerDetailsOut>
    getApiV1ProfilesProfileUuidFollowersUseCase({
  required String profileUuid,
  int limit = 100,
  int offset = 0,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93ZXJz(
    profileUuid: profileUuid,
    limit: limit,
    offset: offset,
  );
}

Future<List<ProfileFewerDetailsOut>>
    getApiV1ProfilesProfileUuidFollowersSearchUseCase({
  required String profileUuid,
  required String username,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93ZXJzU2VhcmNo(
    profileUuid: profileUuid,
    username: username,
  );
}

Future<PaginatedResponseProfileFewerDetailsOut>
    getApiV1ProfilesProfileUuidFollowingUseCase({
  required String profileUuid,
  int limit = 100,
  int offset = 0,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93aW5n(
    profileUuid: profileUuid,
    limit: limit,
    offset: offset,
  );
}

Future<SimpleResponse> postApiV1ProfilesProfileUuidFollowAnotherProfileUseCase({
  required String profileUuid,
  required String profileToFollow,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZEZvbGxvd0Fub3RoZxjQcm9maWxl(
    profileUuid: profileUuid,
    profileToFollow: profileToFollow,
  );
}

Future<SimpleResponse>
    deleteApiV1ProfilesProfileUuidUnfollowAnotherProfileUseCase({
  required String profileUuid,
  required String profileToUnfollow,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo
      .zGVsZXRlQXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkVw5mb2xsb3dBbm90aGVyUHJvZmlsZQ(
    profileUuid: profileUuid,
    profileToUnfollow: profileToUnfollow,
  );
}

Future<SimpleResponse> deleteApiV1ProfilesProfileUuidRemoveMyFollowerUseCase({
  required String profileUuid,
  required String profileToRemove,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.zGVsZXRlQXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkUmVtb3ZlTXlGb2xsb3dlcg(
    profileUuid: profileUuid,
    profileToRemove: profileToRemove,
  );
}

Future<SimpleResponse>
    postApiV1ProfilesProfileUuidRequestToFollowPrivateProfileUseCase({
  required String profileUuid,
  required String profileToRequestToFollow,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo
      .cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFJlcXVlc3RUb0ZvbGxvd1ByaXZhdGVQcm9maWxl(
    profileUuid: profileUuid,
    profileToRequestToFollow: profileToRequestToFollow,
  );
}

Future<SimpleResponse>
    postApiV1ProfilesProfileUuidAcceptOrRejectFollowRequestUseCase({
  required String profileUuid,
  required String profileToAcceptOrReject,
  required bool isAccepted,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo
      .cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZEFjY2VwdE9yUmVqZwn0Rm9sbG93UmVxdWVzdA(
    profileUuid: profileUuid,
    profileToAcceptOrReject: profileToAcceptOrReject,
    isAccepted: isAccepted,
  );
}

Future<void> postApiV1ProfilesCancelerCancelRequestToFollowUseCase({
  required String canceler,
  required String profileToCancelFollowRequest,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxUHJvZmlsZxndyw5jZWxlckNhbmNlbFJlcXVlc3RUb0ZvbGxvdw(
    canceler: canceler,
    profileToCancelFollowRequest: profileToCancelFollowRequest,
  );
}

Future<ProfileOut> postApiV1ProfilesProfileUuidTogglePrivateProfileModeUseCase({
  required String profileUuid,
  required bool isPrivate,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo
      .cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFRvZ2dsZVByaXZhdGVQcm9maWxlTw9kZQ(
    profileUuid: profileUuid,
    isPrivate: isPrivate,
  );
}

Future<ProfileMetaDataOut> postApiV1ProfilesProfileUuidViewUseCase({
  required String profileUuid,
  required String viewerUuid,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFZpZXc(
    profileUuid: profileUuid,
    viewerUuid: viewerUuid,
  );
}

Future<PaginatedResponseProfileOut> getApiV1ProfilesProfileUuidSearchUseCase({
  required String profileUuid,
  int limit = 50,
  int offset = 0,
  bool proUserOnly = false,
  String? username,
  String? role,
  String? genre,
  String? instrument,
  DateTime? startDate,
  DateTime? endDate,
  required UHJvZmlsZVJlcG8 repo,
}) {
  return repo.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkU2VhcmNo(
    profileUuid: profileUuid,
    limit: limit,
    offset: offset,
    proUserOnly: proUserOnly,
    username: username,
    role: role,
    genre: genre,
    instrument: instrument,
    startDate: startDate,
    endDate: endDate,
  );
}
