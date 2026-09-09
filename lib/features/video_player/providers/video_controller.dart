import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:volume_controller/volume_controller.dart';

part 'video_controller.g.dart';

@Riverpod(keepAlive: true)
class VideoController extends _$VideoController {
  @override
  VideoState build() => VideoState.initial();

  void current(int value) {
    state = state.copyWith(current: value, isPause: false);
    ref.notifyListeners();
  }

  void showMenu(bool value) {
    state = state.copyWith(showMenu: value);
    ref.notifyListeners();
  }

  void isPause(bool value) {
    state = state.copyWith(isPause: value);
    ref.notifyListeners();
  }

  void showPlayPauseIcon(bool value) {
    state = state.copyWith(showPlayPauseIcon: value);
    ref.notifyListeners();
  }

  void showHeartIcon(bool value) {
    state = state.copyWith(showHeartIcon: value);
    ref.notifyListeners();
  }

  void showInfoSheet(bool value) {
    state = state.copyWith(showInfoSheet: value);
    ref.notifyListeners();
  }

  void isMute(bool value) {
    state = state.copyWith(isMute: value);
    ref.notifyListeners();
  }

  void volume(double value) {
    state = state.copyWith(volume: value);
    ref.notifyListeners();

    if (value == 0 && !state.isMute) {
      isMute(true);
    }

    if (value != 0 && state.isMute) {
      isMute(false);
    }
  }

  Future<void> toggleMute() async {
    var mute = !state.isMute;
    await VolumeController.instance.setMute(mute);
    isMute(mute);
  }

  void showingAction(bool value) {
    state = state.copyWith(showingAction: value);
    ref.notifyListeners();
  }

  void items(
    List<PostOut> items, {
    int current = 0,
    bool isPause = true,
    bool showMenu = true,
  }) {
    state = state.copyWith(
      items: items,
      current: current,
      isPause: isPause,
      showMenu: showMenu,
    );
    ref.notifyListeners();
  }
}

class VideoState {
  VideoState({
    required this.current,
    required this.isMute,
    required this.volume,
    required this.showMenu,
    required this.showInfoSheet,
    required this.showHeartIcon,
    required this.showPlayPauseIcon,
    required this.isPause,
    required this.showingAction,
    required this.items,
  });

  final int current;
  final bool isMute;
  final double volume;
  final bool showMenu;
  final bool showInfoSheet;
  final bool showHeartIcon;
  final bool showPlayPauseIcon;
  final bool isPause;
  final bool showingAction;
  final List<PostOut> items;

  factory VideoState.initial() => VideoState(
        volume: 0,
        current: 0,
        isMute: false,
        showMenu: true,
        isPause: false,
        showInfoSheet: false,
        showHeartIcon: false,
        showingAction: false,
        showPlayPauseIcon: false,
        items: [],
      );

  VideoState copyWith({
    int? current,
    bool? isMute,
    double? volume,
    bool? showMenu,
    bool? showInfoSheet,
    bool? showHeartIcon,
    bool? showPlayPauseIcon,
    bool? isPause,
    bool? showingAction,
    List<PostOut>? items,
  }) {
    return VideoState(
      current: current ?? this.current,
      isMute: isMute ?? this.isMute,
      volume: volume ?? this.volume,
      showMenu: showMenu ?? this.showMenu,
      showInfoSheet: showInfoSheet ?? this.showInfoSheet,
      showHeartIcon: showHeartIcon ?? this.showHeartIcon,
      showPlayPauseIcon: showPlayPauseIcon ?? this.showPlayPauseIcon,
      isPause: isPause ?? this.isPause,
      showingAction: showingAction ?? this.showingAction,
      items: items ?? this.items,
    );
  }
}
