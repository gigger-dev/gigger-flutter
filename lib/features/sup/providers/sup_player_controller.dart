import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sup_player_controller.g.dart';

@riverpod
class SupPlayerController extends _$SupPlayerController {
  @override
  SupPlayerState build() => SupPlayerState(isPause: false);

  void isPause(bool value) {
    state = state.copyWith(isPause: value);
  }

  void storyIndex(int value) {
    state = state.copyWith(storyIndex: value);
    ref.notifyListeners();
  }
}

class SupPlayerState {
  final bool isPause;
  final int storyIndex;

  SupPlayerState({required this.isPause, this.storyIndex = 0});

  SupPlayerState copyWith({
    bool? isPause,
    int? storyIndex,
  }) {
    return SupPlayerState(
      isPause: isPause ?? this.isPause,
      storyIndex: storyIndex ?? this.storyIndex,
    );
  }
}
