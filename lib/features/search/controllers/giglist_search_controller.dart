import 'package:mobile_gigger_app/features/post_form/data/gig_lists/gig_lists_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/gig_lists/gig_lists_use_case.dart';
import 'package:mobile_gigger_app/models/paginated_response_gig_list_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'giglist_search_controller.g.dart';

@riverpod
class GiglistSearchController extends _$GiglistSearchController {
  @override
  Future<PaginatedResponseGigListOut> build({
    required String searcherUuid,
    required String? title,
    required bool isLookingFor,
    required bool isPerformer,
    required num? price,
  }) {
    return getApiV1GigListSearcherUuidSearchUseCase(
      title: title,
      price: price,
      isPerformer: isPerformer,
      searcherUuid: searcherUuid,
      isLookingFor: isLookingFor,
      repo: ref.read(gigListsRepoProvider),
    );
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
