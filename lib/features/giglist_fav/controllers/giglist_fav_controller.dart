import 'package:mobile_gigger_app/features/post_form/data/gig_lists/gig_lists_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/gig_lists/gig_lists_use_case.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'giglist_fav_controller.g.dart';

@Riverpod(keepAlive: true)
class GiglistFavController extends _$GiglistFavController {
  @override
  Future<List<GigListOut>> build(String profileUuid) {
    return getApiV1GigListProfileUuidFavUseCase(
      profileUuid: profileUuid,
      repo: ref.read(gigListsRepoProvider),
    );
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
