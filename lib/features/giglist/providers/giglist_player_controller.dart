import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volume_controller/volume_controller.dart';

part 'giglist_player_controller.g.dart';

@riverpod
class GiglistPlayerController extends _$GiglistPlayerController {
  @override
  GiglistPlayerState build() {
    return GiglistPlayerState(isMute: false, isMore: false);
  }

  void isMute(bool isMute) {
    state = state.copyWith(isMute: isMute);
  }

  void isMore(bool isMore) {
    state = state.copyWith(isMore: isMore);
  }

  Future<void> toggleMute() async {
    var mute = !state.isMute;
    await VolumeController.instance.setMute(mute);
    isMute(mute);
  }

  void current(int value) {
    state = state.copyWith(current: value);
  }
}

class GiglistPlayerState {
  final bool isMute;
  final bool isMore;
  final int current;

  GiglistPlayerState({
    required this.isMute,
    required this.isMore,
    this.current = 0,
  });

  GiglistPlayerState copyWith({
    bool? isMute,
    bool? isMore,
    int? current,
  }) {
    return GiglistPlayerState(
      isMute: isMute ?? this.isMute,
      isMore: isMore ?? this.isMore,
      current: current ?? this.current,
    );
  }
}
