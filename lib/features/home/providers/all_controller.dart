import 'package:mobile_gigger_app/features/home/providers/artist_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/event_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_giglist_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'all_controller.g.dart';

@Riverpod(keepAlive: true)
class AllController extends _$AllController {
  @override
  List<dynamic> build() {
    var videos = ref
            .watch(recommendedVideoControllerProvider)
            .whenData((v) => v.items)
            .valueOrNull ??
        [];
    var artists = ref
            .watch(artistControllerProvider)
            .whenData((v) => v.items)
            .valueOrNull ??
        [];

    var giglists = ref
            .watch(recommendedGiglistControllerProvider)
            .whenData((v) => v.items)
            .valueOrNull ??
        [];

    var events = ref
            .watch(eventControllerProvider)
            .whenData((v) => v.items)
            .valueOrNull ??
        [];

    var items = [...videos, ...artists, ...giglists, ...events];
    items.shuffle();
    return items;
  }
}
