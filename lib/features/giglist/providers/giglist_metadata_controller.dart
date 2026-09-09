import 'package:mobile_gigger_app/features/post_form/data/gig_lists/gig_lists_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/gig_lists/gig_lists_use_case.dart';
import 'package:mobile_gigger_app/models/gig_list_metadata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'giglist_metadata_controller.g.dart';

@riverpod
class GigListMetadataController extends _$GigListMetadataController {
  @override
  Future<GigListMetadata> build({
    required String gigListUuid,
    required String viewerUuid,
  }) {
    return postApiV1GigListGigListUuidMetadataUseCase(
      gigListUuid: gigListUuid,
      viewerUuid: viewerUuid,
      repo: ref.read(gigListsRepoProvider),
    );
  }

  Future<void> toggleStar() async {
    try {
      var r = await postApiV1GigListGigListUuidStarUseCase(
        gigListUuid: gigListUuid,
        starGiverUuid: viewerUuid,
        repo: ref.read(gigListsRepoProvider),
      );

      state = AsyncData(r);
    } catch (_) {}
  }

  Future<void> toggleLike() async {
    try {
      var r = await postApiV1GigListGigListUuidLikeUseCase(
        gigListUuid: gigListUuid,
        likerUuid: viewerUuid,
        repo: ref.read(gigListsRepoProvider),
      );

      state = AsyncData(r);
    } catch (_) {}
  }
}
