// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../../models/gig_list_create.dart';
import '../../../../../models/gig_list_metadata.dart';
import '../../../../../models/gig_list_out.dart';
import '../../../../../models/gig_list_update.dart';
import '../../../../../models/paginated_response_gig_list_out.dart';
import '../../../../../models/simple_response.dart';

import '../../domain/gig_lists/gig_lists_repo.dart';
import '../../../../../gen/gig_lists/z2ln_x2xpc3_rz_x2_nsa_w_vud_a.dart';

class R2lnTGlzdHNSZXBvSW1wbA implements R2lnTGlzdHNSZXBv {
  R2lnTGlzdHNSZXBvSW1wbA(this.client);

  final R2lnTGlzdHNDbGllbnQ client;

  @override
  Future<PaginatedResponseGigListOut> z2V0QXBpVjFHaWdMaXn0() {
    return client.z2V0QXBpVjFHaWdMaXn0();
  }

  @override
  Future<GigListOut> cG9zdEFwaVYxR2lnTGlzdA({
    required GigListCreate body,
  }) {
    return client.cG9zdEFwaVYxR2lnTGlzdA(
      body: body,
    );
  }

  @override
  Future<PaginatedResponseGigListOut>
      z2V0QXBpVjFHaWdMaXn0UmVjb21tZw5kZwrHaWdMaXn0({
    int limit = 100,
    int offset = 0,
  }) {
    return client.z2V0QXBpVjFHaWdMaXn0UmVjb21tZw5kZwrHaWdMaXn0(
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<SimpleResponse> zGVsZXRlQXBpVjFHaWdMaXn0R2lnTGlzdFv1aWQ({
    required String gigListUuid,
  }) {
    return client.zGVsZXRlQXBpVjFHaWdMaXn0R2lnTGlzdFv1aWQ(
      gigListUuid: gigListUuid,
    );
  }

  @override
  Future<GigListOut> cGf0Y2hBcGlWMUdpZ0xpc3RHaWdMaXn0VXVpZA({
    required String gigListUuid,
    required GigListUpdate body,
  }) {
    return client.cGf0Y2hBcGlWMUdpZ0xpc3RHaWdMaXn0VXVpZA(
      gigListUuid: gigListUuid,
      body: body,
    );
  }

  @override
  Future<List<GigListOut>> z2V0QXBpVjFHaWdMaXn0UHJvZmlsZvv1aWQ({
    required String profileUuid,
  }) {
    return client.z2V0QXBpVjFHaWdMaXn0UHJvZmlsZvv1aWQ(
      profileUuid: profileUuid,
    );
  }

  @override
  Future<GigListMetadata> cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkU3Rhcg({
    required String gigListUuid,
    required String starGiverUuid,
  }) {
    return client.cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkU3Rhcg(
      gigListUuid: gigListUuid,
      starGiverUuid: starGiverUuid,
    );
  }

  @override
  Future<GigListMetadata> cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkTwv0YWRhdGE({
    required String gigListUuid,
    required String viewerUuid,
  }) {
    return client.cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkTwv0YWRhdGE(
      gigListUuid: gigListUuid,
      viewerUuid: viewerUuid,
    );
  }

  @override
  Future<GigListMetadata> cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkTGlrZQ({
    required String gigListUuid,
    required String likerUuid,
  }) {
    return client.cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkTGlrZQ(
      gigListUuid: gigListUuid,
      likerUuid: likerUuid,
    );
  }

  @override
  Future<GigListOut> z2V0QXBpVjFHaWdMaXn0R2lnTGlzdFv1aWrhzxq({
    required String gigListUuid,
  }) {
    return client.z2V0QXBpVjFHaWdMaXn0R2lnTGlzdFv1aWrhzxq(
      gigListUuid: gigListUuid,
    );
  }

  @override
  Future<List<GigListOut>> z2V0QXBpVjFHaWdMaXn0UHJvZmlsZvv1aWrgyxy({
    required String profileUuid,
  }) {
    return client.z2V0QXBpVjFHaWdMaXn0UHJvZmlsZvv1aWrgyxy(
      profileUuid: profileUuid,
    );
  }

  @override
  Future<PaginatedResponseGigListOut>
      z2V0QXBpVjFHaWdMaXn0U2VhcmNoZxjVdWlkU2VhcmNo({
    required String searcherUuid,
    bool isPerformer = false,
    bool isLookingFor = false,
    int limit = 50,
    int offset = 0,
    String? title,
    num? price,
    String? place,
  }) {
    return client.z2V0QXBpVjFHaWdMaXn0U2VhcmNoZxjVdWlkU2VhcmNo(
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
}
