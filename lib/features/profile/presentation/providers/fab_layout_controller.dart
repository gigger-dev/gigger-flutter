import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/models/post_out.dart';

part 'fab_layout_controller.g.dart';

@Riverpod(keepAlive: true)
class FabLayoutController extends _$FabLayoutController {
  @override
  Future<List<String>> build(String profileUuid) async {
    try {
      var r = await getApiV1PostsLayoutUseCase(
        profileUuid: profileUuid,
        repo: ref.read(postsRepoProvider),
      );

      return r.layout.values.toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> setIndex(List<PostOut> items) async {
    await update((state) {
      return items.map((e) => e.uuid).toList();
    });
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
