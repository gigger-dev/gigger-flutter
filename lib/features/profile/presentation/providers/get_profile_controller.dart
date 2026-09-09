import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/metadata_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_profile_controller.g.dart';

@riverpod
class GetProfileController extends _$GetProfileController {
  @override
  Future<ProfileOut> build(String uuid) {
    return getApiV1ProfilesProfileUuidUseCase(
      profileUuid: uuid,
      repo: ref.read(profileRepoProvider),
    );
  }

  Future<void> follow() async {
    var profileUuid = ref.read(profileControllerProvider).value!.uuid;

    var state = await future;

    try {
      if (state.isPrivateProfile) {
        await postApiV1ProfilesProfileUuidRequestToFollowPrivateProfileUseCase(
          profileUuid: profileUuid,
          profileToRequestToFollow: uuid,
          repo: ref.read(profileRepoProvider),
        );
      } else {
        await postApiV1ProfilesProfileUuidFollowAnotherProfileUseCase(
          profileToFollow: uuid,
          profileUuid: profileUuid,
          repo: ref.read(profileRepoProvider),
        );
      }
    } catch (_) {}
  }

  Future<void> unfollow() async {
    var profileUuid = ref.read(profileControllerProvider).value!.uuid;

    var r = await ref.read(metadataControllerProvider(uuid).future);

    var metadata = r.relationshipMetaData!;

    if (metadata.isAlreadyFollowing) {
      await deleteApiV1ProfilesProfileUuidUnfollowAnotherProfileUseCase(
        profileToUnfollow: uuid,
        profileUuid: profileUuid,
        repo: ref.read(profileRepoProvider),
      );
    }

    if (metadata.isAlreadyRequestedToFollow ?? false) {
      await postApiV1ProfilesCancelerCancelRequestToFollowUseCase(
        canceler: profileUuid,
        profileToCancelFollowRequest: uuid,
        repo: ref.read(profileRepoProvider),
      );
    }
    try {} catch (_) {}
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
