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

import '../domain/profiles_repo.dart';
import '../../../../../gen/c_h_jv_zmls_zx_nf_y2xp_zw50.dart';

class UHJvZmlsZXNSZXBvSW1wbA implements UHJvZmlsZXNSZXBv {
  UHJvZmlsZXNSZXBvSW1wbA(this.client);

  final UHJvZmlsZXNDbGllbnQ client;

  @override
  Future<List<InterestOut>> z2V0QXBpVjFQcm9maWxlc0ludGVyZxn0cw({
    String? query,
  }) {
    return client.z2V0QXBpVjFQcm9maWxlc0ludGVyZxn0cw(
      query: query,
    );
  }

  @override
  Future<List<MyServicesOut>> z2V0QXBpVjFQcm9maWxlc1NlcnZpY2Vz({
    String? query,
  }) {
    return client.z2V0QXBpVjFQcm9maWxlc1NlcnZpY2Vz(
      query: query,
    );
  }

  @override
  Future<List<SkillOut>> z2V0QXBpVjFQcm9maWxlc1NraWxscw({
    String? query,
  }) {
    return client.z2V0QXBpVjFQcm9maWxlc1NraWxscw(
      query: query,
    );
  }

  @override
  Future<ProfileOut> z2V0QXBpVjFQcm9maWxlcw({
    required String accountUuid,
  }) {
    return client.z2V0QXBpVjFQcm9maWxlcw(
      accountUuid: accountUuid,
    );
  }

  @override
  Future<ProfileOut> cG9zdEFwaVYxUHJvZmlsZxm({
    required ProfileIn body,
  }) {
    return client.cG9zdEFwaVYxUHJvZmlsZxm(
      body: body,
    );
  }

  @override
  Future<ProfileOut> cGf0Y2hBcGlWmvByb2ZpbGVzUHJvZmlsZvv1aWQ({
    required String profileUuid,
    required ProfileUpdate body,
  }) {
    return client.cGf0Y2hBcGlWmvByb2ZpbGVzUHJvZmlsZvv1aWQ(
      profileUuid: profileUuid,
      body: body,
    );
  }

  @override
  Future<PaginatedResponseProfileOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkUmVjb21tZw5kZwrBcnRpc3Q({
    required String profileUuid,
    int limit = 100,
    int offset = 0,
  }) {
    return client.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkUmVjb21tZw5kZwrBcnRpc3Q(
      profileUuid: profileUuid,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<ProfileOut> z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlk({
    required String profileUuid,
  }) {
    return client.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlk(
      profileUuid: profileUuid,
    );
  }

  @override
  Future<ProfileMetaDataOut> z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkTwv0YWRhdGE({
    required String profileUuid,
  }) {
    return client.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkTwv0YWRhdGE(
      profileUuid: profileUuid,
    );
  }

  @override
  Future<PaginatedResponseProfileFewerDetailsOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93ZXJz({
    required String profileUuid,
    int limit = 100,
    int offset = 0,
  }) {
    return client.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93ZXJz(
      profileUuid: profileUuid,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<List<ProfileFewerDetailsOut>>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93ZXJzU2VhcmNo({
    required String profileUuid,
    required String username,
  }) {
    return client.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93ZXJzU2VhcmNo(
      profileUuid: profileUuid,
      username: username,
    );
  }

  @override
  Future<PaginatedResponseProfileFewerDetailsOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93aW5n({
    required String profileUuid,
    int limit = 100,
    int offset = 0,
  }) {
    return client.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93aW5n(
      profileUuid: profileUuid,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<SimpleResponse>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZEZvbGxvd0Fub3RoZxjQcm9maWxl({
    required String profileUuid,
    required String profileToFollow,
  }) {
    return client
        .cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZEZvbGxvd0Fub3RoZxjQcm9maWxl(
      profileUuid: profileUuid,
      profileToFollow: profileToFollow,
    );
  }

  @override
  Future<SimpleResponse>
      zGVsZXRlQXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkVw5mb2xsb3dBbm90aGVyUHJvZmlsZQ({
    required String profileUuid,
    required String profileToUnfollow,
  }) {
    return client
        .zGVsZXRlQXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkVw5mb2xsb3dBbm90aGVyUHJvZmlsZQ(
      profileUuid: profileUuid,
      profileToUnfollow: profileToUnfollow,
    );
  }

  @override
  Future<SimpleResponse>
      zGVsZXRlQXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkUmVtb3ZlTXlGb2xsb3dlcg({
    required String profileUuid,
    required String profileToRemove,
  }) {
    return client
        .zGVsZXRlQXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkUmVtb3ZlTXlGb2xsb3dlcg(
      profileUuid: profileUuid,
      profileToRemove: profileToRemove,
    );
  }

  @override
  Future<SimpleResponse>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFJlcXVlc3RUb0ZvbGxvd1ByaXZhdGVQcm9maWxl({
    required String profileUuid,
    required String profileToRequestToFollow,
  }) {
    return client
        .cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFJlcXVlc3RUb0ZvbGxvd1ByaXZhdGVQcm9maWxl(
      profileUuid: profileUuid,
      profileToRequestToFollow: profileToRequestToFollow,
    );
  }

  @override
  Future<SimpleResponse>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZEFjY2VwdE9yUmVqZwn0Rm9sbG93UmVxdWVzdA({
    required String profileUuid,
    required String profileToAcceptOrReject,
    required bool isAccepted,
  }) {
    return client
        .cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZEFjY2VwdE9yUmVqZwn0Rm9sbG93UmVxdWVzdA(
      profileUuid: profileUuid,
      profileToAcceptOrReject: profileToAcceptOrReject,
      isAccepted: isAccepted,
    );
  }

  @override
  Future<void> cG9zdEFwaVYxUHJvZmlsZxndyw5jZWxlckNhbmNlbFJlcXVlc3RUb0ZvbGxvdw({
    required String canceler,
    required String profileToCancelFollowRequest,
  }) {
    return client
        .cG9zdEFwaVYxUHJvZmlsZxndyw5jZWxlckNhbmNlbFJlcXVlc3RUb0ZvbGxvdw(
      canceler: canceler,
      profileToCancelFollowRequest: profileToCancelFollowRequest,
    );
  }

  @override
  Future<ProfileOut>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFRvZ2dsZVByaXZhdGVQcm9maWxlTw9kZQ({
    required String profileUuid,
    required bool isPrivate,
  }) {
    return client
        .cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFRvZ2dsZVByaXZhdGVQcm9maWxlTw9kZQ(
      profileUuid: profileUuid,
      isPrivate: isPrivate,
    );
  }

  @override
  Future<ProfileMetaDataOut> cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFZpZXc({
    required String profileUuid,
    required String viewerUuid,
  }) {
    return client.cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFZpZXc(
      profileUuid: profileUuid,
      viewerUuid: viewerUuid,
    );
  }

  @override
  Future<PaginatedResponseProfileOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkU2VhcmNo({
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
  }) {
    return client.z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkU2VhcmNo(
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
}
