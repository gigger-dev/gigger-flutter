import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/models/hash_tag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hashtag_controller.g.dart';

@Riverpod(keepAlive: true)
class HashtagAllController extends _$HashtagAllController {
  @override
  List<HashTag> build() => [];

  void add(List<HashTag> items) {
    for (var e in items) {
      if (state.contains(e)) continue;

      state.add(e);
    }
  }
}

@Riverpod(keepAlive: true)
class HashtagController extends _$HashtagController {
  @override
  List<HashTag> build() => [];

  Future<void> search(String query) async {
    var repo = ref.read(postsRepoProvider);
    state = await getApiV1PostsHashtagsUseCase(repo: repo, query: query);
    ref.read(hashtagAllControllerProvider.notifier).add(state);
  }
}
