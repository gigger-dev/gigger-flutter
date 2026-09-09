// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../../models/paginated_response_profile_fewer_details_out.dart';
import '../../../../../models/simple_response.dart';
import '../../../../../models/sup_create.dart';
import '../../../../../models/sup_created_from_enum.dart';
import '../../../../../models/sup_metadata.dart';
import '../../../../../models/sup_out.dart';

import '../../domain/sup/sup_repo.dart';
import '../../../../../gen/sup/c3_vw_x2_nsa_w_vud_a.dart';

class U3VwUmVwb0ltcGw implements U3VwUmVwbw {
  U3VwUmVwb0ltcGw(this.client);

  final U3VwQ2xpZW50 client;

  @override
  Future<SupOut> cG9zdEFwaVYxU3Vw({
    required SupCreate body,
  }) {
    return client.cG9zdEFwaVYxU3Vw(
      body: body,
    );
  }

  @override
  Future<PaginatedResponseProfileFewerDetailsOut> z2V0QXBpVjFTdXA({
    SupCreatedFromEnum createdFrom = SupCreatedFromEnum.none,
    int limit = 100,
    int offset = 0,
  }) {
    return client.z2V0QXBpVjFTdXA(
      createdFrom: createdFrom,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<List<SupOut>> z2V0QXBpVjFTdXBQcm9maWxlVXVpZA({
    required String profileUuid,
    required SupCreatedFromEnum createdFrom,
  }) {
    return client.z2V0QXBpVjFTdXBQcm9maWxlVXVpZA(
      profileUuid: profileUuid,
      createdFrom: createdFrom,
    );
  }

  @override
  Future<SimpleResponse> zGVsZXRlQXBpVjFTdXBTdXBVdWlk({
    required String supUuid,
  }) {
    return client.zGVsZXRlQXBpVjFTdXBTdXBVdWlk(
      supUuid: supUuid,
    );
  }

  @override
  Future<SupMetadata> cG9zdEFwaVYxU3VwU3VwVXVpZExpa2U({
    required String supUuid,
    required String likerUuid,
  }) {
    return client.cG9zdEFwaVYxU3VwU3VwVXVpZExpa2U(
      supUuid: supUuid,
      likerUuid: likerUuid,
    );
  }

  @override
  Future<SupMetadata> z2V0QXBpVjFTdXBTdXBVdWlkTwv0YWRhdGE({
    required String supUuid,
    required String viewerUuid,
  }) {
    return client.z2V0QXBpVjFTdXBTdXBVdWlkTwv0YWRhdGE(
      supUuid: supUuid,
      viewerUuid: viewerUuid,
    );
  }

  @override
  Future<SupMetadata> cG9zdEFwaVyxu3VwU3VwVXVpZFNoYXJl({
    required String supUuid,
    required String sharerUuid,
  }) {
    return client.cG9zdEFwaVyxu3VwU3VwVXVpZFNoYXJl(
      supUuid: supUuid,
      sharerUuid: sharerUuid,
    );
  }

  @override
  Future<SupOut> z2V0QXBpVjFTdXBTdXBVdWlkR2V0({
    required String supUuid,
  }) {
    return client.z2V0QXBpVjFTdXBTdXBVdWlkR2V0(
      supUuid: supUuid,
    );
  }

  @override
  Future<SupMetadata> cG9zdEFwaVYxU3VwU3VwVXVpZFZpZXc({
    required String supUuid,
    required String viewerUuid,
  }) {
    return client.cG9zdEFwaVYxU3VwU3VwVXVpZFZpZXc(
      supUuid: supUuid,
      viewerUuid: viewerUuid,
    );
  }
}
