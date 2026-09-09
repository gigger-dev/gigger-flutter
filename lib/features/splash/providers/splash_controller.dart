import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_controller.g.dart';

@Riverpod(keepAlive: true)
class SplashController extends _$SplashController {
  @override
  String? build() => null;

  void update(String? msg) {
    state = msg;
  }
}
