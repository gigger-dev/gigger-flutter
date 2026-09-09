import 'package:mobile_gigger_app/features/connection/providers/unfollow_list_controller.dart';
import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/models/paginated_response_profile_fewer_details_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'following_controller.g.dart';

@riverpod
class FollowingController extends _$FollowingController {
  @override
  Future<PaginatedResponseProfileFewerDetailsOut> build(
    String profileUuid,
  ) async {
    var r = await getApiV1ProfilesProfileUuidFollowingUseCase(
      profileUuid: profileUuid,
      repo: ref.read(profileRepoProvider),
    );

    ref.read(unfollowListControllerProvider.notifier).refresh();

    return r;
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
