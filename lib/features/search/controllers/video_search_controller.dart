import 'package:mobile_gigger_app/features/post_form/data/posts/posts_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/posts/posts_use_case.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'video_search_controller.g.dart';

@riverpod
class VideoSearchController extends _$VideoSearchController {
  @override
  Future<List<PostOut>> build({
    required String title,
    required String keywords,
    required String searcherUuid,
    String? genre,
  }) async {
    var r = await getApiV1PostsSearcherUuidSearchUseCase(
      title: title,
      genre: genre ?? '',
      keywords: keywords,
      searcherUuid: searcherUuid,
      repo: ref.read(postsRepoProvider),
    );

    return r.items;
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
