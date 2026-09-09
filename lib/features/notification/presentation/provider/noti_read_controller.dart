import 'dart:convert';

import 'package:mobile_gigger_app/models/notification_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'noti_read_controller.g.dart';

@Riverpod(keepAlive: true)
class NotiReadController extends _$NotiReadController {
  @override
  Future<List<String>> build() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getStringList('noti_read') ?? [];
  }

  Future<void> read(NotificationOut e) async {
    var state = await future;

    var data = jsonEncode(e.toJson());
    if (state.contains(data)) return;

    var pref = await SharedPreferences.getInstance();
    await pref.setStringList('noti_read', [...state, data]);

    this.state = AsyncData([...state, data]);
  }

  Future<void> delete(int id) async {
    var state = await future;

    state.removeWhere((e) => jsonDecode(e)['id'] == id.toString());

    var pref = await SharedPreferences.getInstance();
    await pref.setStringList('noti_read', state);
  }
}
