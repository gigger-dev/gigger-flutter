import 'package:mobile_gigger_app/features/post_form/data/gig_lists/gig_lists_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/gig_lists/gig_lists_use_case.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:mobile_gigger_app/models/paginated_response_gig_list_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'giglist_controller.g.dart';

@Riverpod(keepAlive: true)
class GiglistController extends _$GiglistController {
  @override
  Future<PaginatedResponseGigListOut> build() => get();

  Future<PaginatedResponseGigListOut> get() {
    return getApiV1GigListUseCase(ref.read(gigListsRepoProvider));
  }

  Future<void> refresh() async {
    try {
      var r = await get();
      state = AsyncData(r);
    } catch (_) {}
  }

  Future<void> updateData(GigListOut r) async {
    var state = await future;
    var items = List<GigListOut>.from(state.items);
    var index = items.indexWhere((e) => e.uuid == r.uuid);
    items[index] = r;
    this.state = AsyncData(state.copyWith(items: items));
  }

  Future<void> add(GigListOut r) async {
    var state = await future;
    var items = List<GigListOut>.from(state.items);
    this.state = AsyncData(state.copyWith(items: [...items, r]));
  }
}

@riverpod
class GiglistProfileController extends _$GiglistProfileController {
  @override
  Future<List<GigListOut>> build(String profileUuid) {
    return getApiV1GigListProfileUuidUseCase(
      profileUuid: profileUuid,
      repo: ref.read(gigListsRepoProvider),
    );
  }
}
