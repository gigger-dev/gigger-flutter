import 'dart:math';

import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_layout_controller.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/models/post_position_metadata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fab_draft_layout_controller.g.dart';

@Riverpod(keepAlive: true)
class FabDraftLayoutController extends _$FabDraftLayoutController {
  @override
  List<String> build(String uuid) => [];

  void set(List<PostOut> items) {
    state = items.map((e) => e.uuid).toList();
  }

  void move({
    required int oldIndex,
    required int newIndex,
  }) {
    // if (oldIndex < newIndex) newIndex -= 1;

    var items = state;

    final temp = items[oldIndex];
    items[oldIndex] = items[newIndex];
    items[newIndex] = temp;

    state = items;
    ref.notifyListeners();
  }

  Future<void> reset() async {
    state = await ref.read(fabLayoutControllerProvider(uuid).future);
    ref.notifyListeners();
  }

  Future<void> save() async {
    try {
      var items = state.sublist(0, min(state.length, 9));
      var r = await postApiV1PostsLayoutUseCase(
        repo: ref.read(postsRepoProvider),
        body: PostPositionMetadata(
          profileUuid: uuid,
          layout: {
            for (var e in items.asMap().entries) '${e.key + 1}': e.value
          },
        ),
      );

      state = r.layout.values.toList();
      ref.notifyListeners();

      ref.read(fabLayoutControllerProvider(uuid).notifier).refresh();
    } catch (_) {}
  }
}
