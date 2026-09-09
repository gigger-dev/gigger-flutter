import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/models/post_metadata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_metadata_controller.g.dart';

@riverpod
class VideoMetadataController extends _$VideoMetadataController {
  @override
  Future<PostMetadata> build({
    required String postUuid,
    required String viewerUuid,
  }) {
    return getApiV1PostsPostUuidMetadataUseCase(
      postUuid: postUuid,
      viewerUuid: viewerUuid,
      repo: ref.read(postsRepoProvider),
    );
  }

  Future<void> toggleLike() async {
    var r = await postApiV1PostsPostUuidLikeUseCase(
      postUuid: postUuid,
      likerUuid: viewerUuid,
      repo: ref.read(postsRepoProvider),
    );

    state = AsyncData(r);
  }
}
