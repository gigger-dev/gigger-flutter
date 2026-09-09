// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import '../../../../../models/gig_list_create.dart';
import '../../../../../models/gig_list_metadata.dart';
import '../../../../../models/gig_list_out.dart';
import '../../../../../models/gig_list_update.dart';
import '../../../../../models/paginated_response_gig_list_out.dart';
import '../../../../../models/simple_response.dart';

abstract class R2lnTGlzdHNSZXBv {
  Future<PaginatedResponseGigListOut> z2V0QXBpVjFHaWdMaXn0();

  Future<GigListOut> cG9zdEFwaVYxR2lnTGlzdA({
    required GigListCreate body,
  });

  Future<PaginatedResponseGigListOut>
      z2V0QXBpVjFHaWdMaXn0UmVjb21tZw5kZwrHaWdMaXn0({
    int limit = 100,
    int offset = 0,
  });

  Future<SimpleResponse> zGVsZXRlQXBpVjFHaWdMaXn0R2lnTGlzdFv1aWQ({
    required String gigListUuid,
  });

  Future<GigListOut> cGf0Y2hBcGlWMUdpZ0xpc3RHaWdMaXn0VXVpZA({
    required String gigListUuid,
    required GigListUpdate body,
  });

  Future<List<GigListOut>> z2V0QXBpVjFHaWdMaXn0UHJvZmlsZvv1aWQ({
    required String profileUuid,
  });

  Future<GigListMetadata> cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkU3Rhcg({
    required String gigListUuid,
    required String starGiverUuid,
  });

  Future<GigListMetadata> cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkTwv0YWRhdGE({
    required String gigListUuid,
    required String viewerUuid,
  });

  Future<GigListMetadata> cG9zdEFwaVYxR2lnTGlzdEdpZ0xpc3RVdWlkTGlrZQ({
    required String gigListUuid,
    required String likerUuid,
  });

  Future<GigListOut> z2V0QXBpVjFHaWdMaXn0R2lnTGlzdFv1aWrhzxq({
    required String gigListUuid,
  });

  Future<List<GigListOut>> z2V0QXBpVjFHaWdMaXn0UHJvZmlsZvv1aWrgyxy({
    required String profileUuid,
  });

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
  });
}
