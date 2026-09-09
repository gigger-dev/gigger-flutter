import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_offset_controller.g.dart';

@riverpod
class ProfileOffsetController extends _$ProfileOffsetController {
  @override
  double build() => 0;

  void update(double value) {
    state = value;
  }
}
