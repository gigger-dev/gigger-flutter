import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/models/all_search_results.dart';

part 'all_search_controller.g.dart';

@riverpod
class AllSearchController extends _$AllSearchController {
  @override
  Future<AllSearchState> build({
    required String keyword,
    required String searcherUuid,
  }) async {
    var r = await getApiV1PostsSearcherUuidSearchAllUseCase(
      keywords: keyword,
      searcherUuid: searcherUuid,
      repo: ref.read(postsRepoProvider),
    );

    var items = [...r.profiles, ...r.posts, ...r.gigList];
    items.shuffle();

    return AllSearchState(results: r, items: items);
  }

  void refresh() {
    ref.invalidateSelf();
  }
}

class AllSearchState {
  final List<Object> items;
  final AllSearchResults results;

  AllSearchState({required this.results, required this.items});

  AllSearchState copyWith({
    List<Object>? items,
    AllSearchResults? results,
  }) {
    return AllSearchState(
      items: items ?? this.items,
      results: results ?? this.results,
    );
  }
}
