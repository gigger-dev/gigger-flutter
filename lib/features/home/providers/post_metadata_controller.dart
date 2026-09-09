import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/models/post_metadata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_metadata_controller.g.dart';

@Riverpod(keepAlive: true)
class PostMetadataController extends _$PostMetadataController {
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

  Future<void> view() async {
    try {
      var state = await future;
      if (state.hasAlreadyViewed) return;

      var r = await postApiV1PostsPostUuidViewUseCase(
        postUuid: postUuid,
        viewerUuid: viewerUuid,
        repo: ref.read(postsRepoProvider),
      );

      ref.read(recommendedVideoControllerProvider.notifier).updateViewCount(
            postUuid: postUuid,
            viewCount: r.viewCount,
          );

      this.state = AsyncData(r);
    } catch (_) {}
  }
}
