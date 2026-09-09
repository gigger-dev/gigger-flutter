import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_controller.g.dart';

@Riverpod(keepAlive: true)
class MainController extends _$MainController {
  @override
  MainState build() => MainState();

  void bottom(int value) {
    state = state.copyWith(bottom: value);
  }

  void homeSlideIndex(int value) {
    state = state.copyWith(homeSlideIndex: value);
  }

  void reset() {
    state = MainState();
  }
}

class MainState {
  final int bottom;
  final int homeSlideIndex;

  MainState({this.bottom = 0, this.homeSlideIndex = 0});

  MainState copyWith({
    int? bottom,
    int? homeSlideIndex,
  }) {
    return MainState(
      bottom: bottom ?? this.bottom,
      homeSlideIndex: homeSlideIndex ?? this.homeSlideIndex,
    );
  }
}
