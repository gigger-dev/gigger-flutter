import 'package:mobile_gigger_app/features/home/providers/self_event_controller.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'self_event_search_controller.g.dart';

@Riverpod(keepAlive: true)
class SelfEventSearchController extends _$SelfEventSearchController {
  @override
  Future<List<EventOut>> build(String query) async {
    var items = await ref.watch(selfEventControllerProvider.future);
    if (query.isEmpty) return items;

    return items
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
