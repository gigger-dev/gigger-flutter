import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unfollow_list_controller.g.dart';

@Riverpod(keepAlive: true)
class UnfollowListController extends _$UnfollowListController {
  @override
  List<String> build() => [];

  void add(String uuid) {
    state.add(uuid);
    ref.notifyListeners();
  }

  void remove(String uuid) {
    state.remove(uuid);
    ref.notifyListeners();
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
