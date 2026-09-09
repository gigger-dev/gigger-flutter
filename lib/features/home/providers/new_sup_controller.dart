import 'package:mobile_gigger_app/models/sup_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'new_sup_controller.g.dart';

@Riverpod(keepAlive: true)
class NewSupController extends _$NewSupController {
  @override
  Map<String, Map<String, bool>> build(String uuid) => {};

  Future<void> view(uuid) async {
    var pref = await SharedPreferences.getInstance();

    if (pref.getBool(uuid) == false) return;

    await pref.setBool(uuid, false);

    state[this.uuid]![uuid] = false;
    ref.notifyListeners();
  }

  Future<void> get(List<SupOut> sups) async {
    var pref = await SharedPreferences.getInstance();

    Map<String, bool> data = {};

    for (var e in sups) {
      data[e.uuid] = pref.getBool(e.uuid) ?? true;
    }

    state[uuid] = data;
    ref.notifyListeners();
  }
}
