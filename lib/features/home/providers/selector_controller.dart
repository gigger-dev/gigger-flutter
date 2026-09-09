import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selector_controller.g.dart';

@Riverpod(keepAlive: true)
class SelectorController extends _$SelectorController {
  @override
  SupCreatedFromEnum build() => SupCreatedFromEnum.none;

  void update(int index) {
    state = switch (index) {
      2 => SupCreatedFromEnum.artist,
      3 => SupCreatedFromEnum.post,
      4 => SupCreatedFromEnum.event,
      5 => SupCreatedFromEnum.proService,
      6 => SupCreatedFromEnum.campaign,
      7 => SupCreatedFromEnum.membership,
      8 => SupCreatedFromEnum.gigList,
      int() => SupCreatedFromEnum.none,
    };
    ref.notifyListeners();
  }

  void updateEnum(SupCreatedFromEnum createFrom) {
    state = createFrom;
    ref.notifyListeners();
  }
}
