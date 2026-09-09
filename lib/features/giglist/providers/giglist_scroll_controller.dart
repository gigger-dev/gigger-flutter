import 'package:mobile_gigger_app/features/giglist_fav/controllers/giglist_fav_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_giglist_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/giglist_controller.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'giglist_scroll_controller.g.dart';

@Riverpod(keepAlive: true)
class GiglistScrollController extends _$GiglistScrollController {
  @override
  Future<List<GigListOut>> build({
    bool isFav = false,
    bool? isVisitor,
    String? profileUuid,
  }) async {
    if (isFav) {
      if (profileUuid == null) return [];
      return ref.watch(giglistFavControllerProvider(profileUuid).future);
    }

    if (isVisitor == null) {
      var r = await ref.watch(recommendedGiglistControllerProvider.future);
      return r.items;
    }

    if (isVisitor) {
      if (profileUuid == null) return [];
      return ref.watch(giglistProfileControllerProvider(profileUuid).future);
    }

    var r = await ref.watch(giglistControllerProvider.future);
    return r.items;
  }
}
