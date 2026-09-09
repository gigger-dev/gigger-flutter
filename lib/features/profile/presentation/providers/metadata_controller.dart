import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/models/profile_meta_data_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metadata_controller.g.dart';

@Riverpod(keepAlive: true)
class MetadataController extends _$MetadataController {
  @override
  Future<ProfileMetaDataOut> build(String profileUuid) {
    return getApiV1ProfilesProfileUuidMetadataUseCase(
      profileUuid: profileUuid,
      repo: ref.read(profileRepoProvider),
    );
  }

  void refresh() {
    ref.invalidateSelf();
  }

  Future<void> view(String uuid) async {
    try {
      var r = await postApiV1ProfilesProfileUuidViewUseCase(
        profileUuid: profileUuid,
        viewerUuid: uuid,
        repo: ref.read(profileRepoProvider),
      );

      state = AsyncData(r);
    } catch (_) {}
  }
}
