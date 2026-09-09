import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'switch_user_controller.g.dart';

@riverpod
class SwitchUserController extends _$SwitchUserController {
  @override
  Future<String?> build() async {
    var storage = ref.read(secureStorageProvider);
    return storage.read(key: 'switch_user_uuid');
  }

  Future<void> set(String uuid) async {
    var storage = ref.read(secureStorageProvider);
    await storage.write(key: 'switch_user_uuid', value: uuid);
    state = AsyncData(uuid);
  }

  Future<void> clear() async {
    var storage = ref.read(secureStorageProvider);
    await storage.delete(key: 'switch_user_uuid');
    state = AsyncData(null);
  }
}
