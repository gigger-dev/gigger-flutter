import 'package:mobile_gigger_app/features/post_form/data/gig_lists/gig_lists_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/gig_lists/gig_lists_use_case.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:mobile_gigger_app/models/paginated_response_gig_list_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recommended_giglist_controller.g.dart';

@Riverpod(keepAlive: true)
class RecommendedGiglistController extends _$RecommendedGiglistController {
  @override
  Future<PaginatedResponseGigListOut> build() => get();

  Future<PaginatedResponseGigListOut> get() {
    return getApiV1GigListRecommendedGigListUseCase(
      repo: ref.read(gigListsRepoProvider),
    );
  }

  Future<void> refresh() async {
    try {
      var r = await get();
      state = AsyncData(r);
    } catch (_) {}
  }

  Future<void> add(GigListOut r) async {
    var state = await future;
    var items = List<GigListOut>.from(state.items);
    this.state = AsyncData(state.copyWith(items: [...items, r]));
  }

  Future<void> updateData(GigListOut r) async {
    var state = await future;
    var items = List<GigListOut>.from(state.items);
    var index = items.indexWhere((e) => e.uuid == r.uuid);
    items[index] = r;
    this.state = AsyncData(state.copyWith(items: items));
  }

  Future<int> getById(String uuid) async {
    var state = await future;
    var items = List<GigListOut>.from(state.items);
    var index = items.indexWhere((e) => e.uuid == uuid);
    if (index != -1) return index;

    var r = await getApiV1GigListGigListUuidGetUseCase(
      gigListUuid: uuid,
      repo: ref.read(gigListsRepoProvider),
    );
    this.state = AsyncData(state.copyWith(items: [r, ...items]));

    return 0;
  }

  Future<int> getIndexByData(GigListOut data) async {
    var state = await future;
    var items = List<GigListOut>.from(state.items);
    var index = items.indexWhere((e) => e.uuid == data.uuid);
    if (index != -1) return index;

    this.state = AsyncData(state.copyWith(items: [data, ...items]));

    return 0;
  }
}
