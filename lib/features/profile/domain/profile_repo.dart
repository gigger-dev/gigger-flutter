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

abstract class UHJvZmlsZVJlcG8 {
  Future<List<InterestOut>> z2V0QXBpVjFQcm9maWxlc0ludGVyZxn0cw({
    String? query,
  });

  Future<List<MyServicesOut>> z2V0QXBpVjFQcm9maWxlc1NlcnZpY2Vz({
    String? query,
  });

  Future<List<SkillOut>> z2V0QXBpVjFQcm9maWxlc1NraWxscw({
    String? query,
  });

  Future<ProfileOut> z2V0QXBpVjFQcm9maWxlcw({
    required String accountUuid,
  });

  Future<ProfileOut> cG9zdEFwaVYxUHJvZmlsZxm({
    required ProfileIn body,
  });

  Future<ProfileOut> cGf0Y2hBcGlWmvByb2ZpbGVzUHJvZmlsZvv1aWQ({
    required String profileUuid,
    required ProfileUpdate body,
  });

  Future<PaginatedResponseProfileOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkUmVjb21tZw5kZwrBcnRpc3Q({
    required String profileUuid,
    int limit = 100,
    int offset = 0,
  });

  Future<ProfileOut> z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlk({
    required String profileUuid,
  });

  Future<ProfileMetaDataOut> z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkTwv0YWRhdGE({
    required String profileUuid,
  });

  Future<PaginatedResponseProfileFewerDetailsOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93ZXJz({
    required String profileUuid,
    int limit = 100,
    int offset = 0,
  });

  Future<List<ProfileFewerDetailsOut>>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93ZXJzU2VhcmNo({
    required String profileUuid,
    required String username,
  });

  Future<PaginatedResponseProfileFewerDetailsOut>
      z2V0QXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkRm9sbG93aW5n({
    required String profileUuid,
    int limit = 100,
    int offset = 0,
  });

  Future<SimpleResponse>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZEZvbGxvd0Fub3RoZxjQcm9maWxl({
    required String profileUuid,
    required String profileToFollow,
  });

  Future<SimpleResponse>
      zGVsZXRlQXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkVw5mb2xsb3dBbm90aGVyUHJvZmlsZQ({
    required String profileUuid,
    required String profileToUnfollow,
  });

  Future<SimpleResponse>
      zGVsZXRlQXBpVjFQcm9maWxlc1Byb2ZpbGVVdWlkUmVtb3ZlTXlGb2xsb3dlcg({
    required String profileUuid,
    required String profileToRemove,
  });

  Future<SimpleResponse>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFJlcXVlc3RUb0ZvbGxvd1ByaXZhdGVQcm9maWxl({
    required String profileUuid,
    required String profileToRequestToFollow,
  });

  Future<SimpleResponse>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZEFjY2VwdE9yUmVqZwn0Rm9sbG93UmVxdWVzdA({
    required String profileUuid,
    required String profileToAcceptOrReject,
    required bool isAccepted,
  });

  Future<void> cG9zdEFwaVYxUHJvZmlsZxndyw5jZWxlckNhbmNlbFJlcXVlc3RUb0ZvbGxvdw({
    required String canceler,
    required String profileToCancelFollowRequest,
  });

  Future<ProfileOut>
      cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFRvZ2dsZVByaXZhdGVQcm9maWxlTw9kZQ({
    required String profileUuid,
    required bool isPrivate,
  });

  Future<ProfileMetaDataOut> cG9zdEFwaVYxUHJvZmlsZxnQcm9maWxlVXVpZFZpZXc({
    required String profileUuid,
    required String viewerUuid,
  });

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
  });
}
