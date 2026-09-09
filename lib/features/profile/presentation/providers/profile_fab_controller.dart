import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_layout_controller.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_fab_controller.g.dart';

@riverpod
class ProfileFabController extends _$ProfileFabController {
  @override
  Future<List<PostOut>> build(String profileUuid) async {
    try {
      var items = await getApiV1PostsProfileUuidFabUseCase(
        profileUuid: profileUuid,
        repo: ref.read(postsRepoProvider),
      );

      var layout =
          await ref.read(fabLayoutControllerProvider(profileUuid).future);
      if (layout.isEmpty) {
        await ref
            .read(fabLayoutControllerProvider(profileUuid).notifier)
            .setIndex(items);
      }

      return items;
    } catch (e) {
      return [];
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
