import 'package:mobile_gigger_app/features/post_form/data/sup/sup_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/sup/sup_use_case.dart';
import 'package:mobile_gigger_app/models/sup_metadata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sup_metadata_controller.g.dart';

@Riverpod(keepAlive: true)
class SupMetadataController extends _$SupMetadataController {
  @override
  Future<SupMetadata> build({
    required String supUuid,
    required String viewerUuid,
  }) {
    return getApiV1SupSupUuidMetadataUseCase(
      supUuid: supUuid,
      viewerUuid: viewerUuid,
      repo: ref.read(supRepoProvider),
    );
  }

  Future<void> toggleLike() async {
    var r = await postApiV1SupSupUuidLikeUseCase(
      supUuid: supUuid,
      likerUuid: viewerUuid,
      repo: ref.read(supRepoProvider),
    );

    state = AsyncData(r);
  }

  Future<void> view() async {
    try {
      var r = await postApiV1SupSupUuidViewUseCase(
        supUuid: supUuid,
        viewerUuid: viewerUuid,
        repo: ref.read(supRepoProvider),
      );

      state = AsyncData(r);
    } catch (_) {}
  }
}
