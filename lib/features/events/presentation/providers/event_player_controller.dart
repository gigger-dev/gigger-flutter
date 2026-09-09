import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:volume_controller/volume_controller.dart';

part 'event_player_controller.g.dart';

@riverpod
class EventPlayerController extends _$EventPlayerController {
  @override
  EventPlayerState build() => EventPlayerState();

  void isMute(bool value) {
    state.isMute = value;
    ref.notifyListeners();
  }

  void isMore(bool value) {
    state.isMore = value;
    ref.notifyListeners();
  }

  void current(int value) {
    state.current = value;
    ref.notifyListeners();
  }

  Future<void> toggleMute() async {
    var mute = !state.isMute;
    await VolumeController.instance.setMute(mute);
    isMute(mute);
  }
}

class EventPlayerState {
  EventPlayerState({
    this.current = 0,
    this.isMore = false,
    this.isMute = false,
  });

  bool isMute;
  bool isMore;
  int current;
}
