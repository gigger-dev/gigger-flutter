import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/models/paginated_response_post_out.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recommended_video_controller.g.dart';

@Riverpod(keepAlive: true)
class RecommendedVideoController extends _$RecommendedVideoController {
  @override
  Future<PaginatedResponsePostOut> build() => get();

  Future<PaginatedResponsePostOut> get() {
    return getApiV1PostsRecommendedPostUseCase(
      repo: ref.read(postsRepoProvider),
    );
  }

  Future<void> loadMore() async {
    await update((state) async {
      var r = await getApiV1PostsRecommendedPostUseCase(
        offset: state.offset + 1,
        repo: ref.read(postsRepoProvider),
      );
      return r.copyWith(items: [...state.items, ...r.items]);
    });
  }

  Future<void> refresh() async {
    try {
      var r = await get();
      state = AsyncData(r);
    } catch (_) {}
  }

  Future<void> updateViewCount({
    required String postUuid,
    required int viewCount,
  }) async {
    await update((state) {
      var items = List<PostOut>.from(state.items);
      var index = items.indexWhere((e) => e.uuid == postUuid);
      if (index == -1) return state;
      items[index] = items[index].copyWith(viewCount: viewCount);
      return state.copyWith(items: items);
    });
  }

  Future<void> updateData(PostOut r) async {
    var state = await future;
    var items = List<PostOut>.from(state.items);
    var index = items.indexWhere((e) => e.uuid == r.uuid);
    items[index] = r;
    this.state = AsyncData(state.copyWith(items: items));
  }

  Future<int?> getById(String uuid) async {
    try {
      var state = await future;
      var items = List<PostOut>.from(state.items);
      var index = items.indexWhere((e) => e.uuid == uuid);
      if (index != -1) return index;

      var r = await getApiV1PostsPostUuidGetUseCase(
        postUuid: uuid,
        repo: ref.read(postsRepoProvider),
      );
      this.state = AsyncData(state.copyWith(items: [r, ...items]));

      return 0;
    } catch (_) {
      return null;
    }
  }

  Future<({int index, List<PostOut> items})> checkAndInsert(
    PostOut data,
  ) async {
    var state = await future;

    var items = state.items;

    var index = items.indexWhere((e) => e.uuid == data.uuid);
    if (index != -1) return (index: index, items: items);

    items.insert(0, data);
    return (index: 0, items: items);
  }
}
