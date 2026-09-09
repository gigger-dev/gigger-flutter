import 'dart:convert';

import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_draft_controller.g.dart';

@Riverpod(keepAlive: true)
class EventDraftController extends _$EventDraftController {
  @override
  Future<List<EventOut>> build() async {
    var drafts =
        await ref.read(secureStorageProvider).read(key: 'event_drafts');

    if (drafts == null) return [];

    return (jsonDecode(drafts) as List)
        .map((e) => EventOut.fromJson(e))
        .toList();
  }

  Future<void> _write(List<EventOut> items) async {
    await ref.read(secureStorageProvider).write(
          key: 'event_drafts',
          value: jsonEncode(items.map((e) => e.toJson()).toList()),
        );
  }

  Future<void> save(EventOut model) async {
    await update((state) async {
      if (state.any((e) => e.uuid == model.uuid)) {
        state.removeWhere((e) => e.uuid == model.uuid);
      }

      var newState = [...state, model];
      await _write(newState);
      return newState;
    });
  }

  Future<void> delete(String uuid) async {
    var state = List<EventOut>.from(await future);
    state.removeWhere((e) => e.uuid == uuid);
    await _write(state);
    ref.invalidateSelf();
  }
}
