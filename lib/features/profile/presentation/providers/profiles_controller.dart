import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/core/providers/token_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profiles_controller.g.dart';

@riverpod
class ProfilesController extends _$ProfilesController {
  @override
  Future<List<ProfileOut>> build() async {
    var storage = ref.read(secureStorageProvider);
    var uuids = await storage.read(key: 'uuids');

    if (uuids == null) return [];

    var uuidValues = jsonDecode(uuids) as List;

    var profiles = <ProfileOut>[];

    for (var uuid in uuidValues) {
      var r = await storage.read(key: uuid);

      if (r == null) {
        uuidValues.remove(uuid);
        continue;
      }

      profiles.add(ProfileOut.fromJson(jsonDecode(r)));
    }

    await storage.write(key: 'uuids', value: jsonEncode(uuidValues));

    return profiles;
  }

  Future<ProfileOut?> getProfile(String uuid) async {
    var state = await future;
    return state.firstWhereOrNull((e) => e.uuid == uuid);
  }

  Future<void> select(String uuid) async {
    await ref.read(tokenControllerProvider.notifier).setUuid(uuid);
    await ref.read(profileControllerProvider.notifier).reset();
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
