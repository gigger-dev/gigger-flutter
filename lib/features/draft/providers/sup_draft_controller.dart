import 'dart:convert';

import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/models/draft_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sup_draft_controller.g.dart';

@Riverpod(keepAlive: true)
class SupDraftController extends _$SupDraftController {
  @override
  Future<List<SupDraftModel>> build() async {
    var drafts = await ref.read(secureStorageProvider).read(key: 'sup_drafts');

    if (drafts == null) return [];

    return (jsonDecode(drafts) as List)
        .map((e) => SupDraftModel.fromJson(e))
        .toList();
  }

  Future<void> _write(List<SupDraftModel> items) async {
    await ref.read(secureStorageProvider).write(
          key: 'sup_drafts',
          value: jsonEncode(items.map((e) => e.toJson()).toList()),
        );
  }

  Future<void> save(SupDraftModel model) async {
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
    await update((state) async {
      state.removeWhere((e) => e.uuid == uuid);
      await _write(state);
      return state;
    });
  }
}
