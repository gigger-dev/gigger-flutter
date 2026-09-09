import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_draft_layout_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_layout_controller.dart';
import 'package:mobile_gigger_app/models/paginated_response_post_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fab_controller.g.dart';

@riverpod
class FabController extends _$FabController {
  @override
  Future<PaginatedResponsePostOut> build(String profileUuid) async {
    try {
      var r = await getApiV1PostsFabUseCase(
        repo: ref.read(postsRepoProvider),
        profileUuid: profileUuid,
      );

      ref
          .read(fabDraftLayoutControllerProvider(profileUuid).notifier)
          .set(r.items);

      var layout =
          await ref.read(fabLayoutControllerProvider(profileUuid).future);
      if (layout.isEmpty) {
        await ref
            .read(fabLayoutControllerProvider(profileUuid).notifier)
            .setIndex(r.items);
      }

      return r;
    } catch (e) {
      return PaginatedResponsePostOut(offset: 0, total: 0, items: []);
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
