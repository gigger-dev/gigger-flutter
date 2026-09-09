import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/metadata_controller.dart';
import 'package:mobile_gigger_app/models/paginated_response_profile_fewer_details_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follower_controller.g.dart';

@riverpod
class FollowerController extends _$FollowerController {
  @override
  Future<PaginatedResponseProfileFewerDetailsOut> build(String profileUuid) {
    return getApiV1ProfilesProfileUuidFollowersUseCase(
      profileUuid: profileUuid,
      repo: ref.read(profileRepoProvider),
    );
  }

  Future<void> acceptOrReject(
    String profileToAcceptOrReject,
    bool isAccepted,
  ) async {
    try {
      var r =
          await postApiV1ProfilesProfileUuidAcceptOrRejectFollowRequestUseCase(
        isAccepted: isAccepted,
        profileUuid: profileUuid,
        repo: ref.read(profileRepoProvider),
        profileToAcceptOrReject: profileToAcceptOrReject,
      );
      if (r.statusCode == 200) {
        ref.invalidateSelf();
        ref.read(metadataControllerProvider(profileUuid).notifier).refresh();
      }
    } catch (_) {}
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
