import 'dart:convert';

import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/models/token_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_controller.g.dart';

const String uuidKey = 'current_uuid';
const String accountUuidKey = 'account_uuid';
const String tokenKey = 'token';
const String refreshTokenKey = 'refreshToken';

String getAccountUuidKey([String? uuid]) {
  if (uuid == null) return accountUuidKey;
  return '${uuid}_$accountUuidKey';
}

String getTokenKey([String? uuid]) {
  if (uuid == null) return tokenKey;
  return '${uuid}_$tokenKey';
}

String getRefreshTokenKey([String? uuid]) {
  if (uuid == null) return refreshTokenKey;
  return '${uuid}_$refreshTokenKey';
}

@riverpod
class TokenController extends _$TokenController {
  @override
  void build() {}

  Future<void> justSetUuid(String uuid) async {
    // debugPrint('[i] justSetUuid: $uuid');
    var storage = ref.read(secureStorageProvider);
    await storage.write(key: uuidKey, value: uuid);
  }

  Future<void> setUuid(String uuid) async {
    // debugPrint('[i] setUuid: $uuid');
    var storage = ref.read(secureStorageProvider);
    await storage.write(key: uuidKey, value: uuid);

    var accountUuid = await storage.read(key: getAccountUuidKey());
    if (accountUuid != null) {
      await storage.write(key: getAccountUuidKey(uuid), value: accountUuid);
      await storage.delete(key: getAccountUuidKey());
    }

    var token = await storage.read(key: getTokenKey());
    if (token != null) {
      await storage.write(key: getTokenKey(uuid), value: token);
      await storage.delete(key: getTokenKey());
    }

    var refreshToken = await storage.read(key: getRefreshTokenKey());
    if (refreshToken != null) {
      await storage.write(key: getRefreshTokenKey(uuid), value: refreshToken);
      await storage.delete(key: getRefreshTokenKey());
    }

    // await changeTokenUuid(uuid);

    // if (r != null) {
    //   await deleteTokens();
    //   await setTokens(r);
    // } else {
    // }
  }

  Future<void> setAccountUuid(String accountUuid) async {
    // debugPrint('[i] setAccountUuid: $accountUuid');
    var storage = ref.read(secureStorageProvider);
    var uuid = await storage.read(key: uuidKey);
    await storage.write(key: getAccountUuidKey(uuid), value: accountUuid);
  }

  // Future<void> setTokens(TokenOut r) async {
  //   var storage = ref.read(secureStorageProvider);
  //   var uuid = await storage.read(key: uuidKey);

  //   debugPrint('[i] setTokens $uuid');

  //   await storage.write(key: getTokenKey(uuid), value: r.accessToken);
  //   await storage.write(key: getRefreshTokenKey(uuid), value: r.refreshToken);
  // }

  // Future<void> changeTokenUuid(String uuid) async {
  //   debugPrint('[i] changeTokenUuid $uuid');

  //   var storage = ref.read(secureStorageProvider);
  //   var token = await storage.read(key: getTokenKey());

  //   if (token == null) return;

  //   var refreshToken = await storage.read(key: getRefreshTokenKey());

  //   await storage.write(key: getTokenKey(uuid), value: token);
  //   await storage.write(key: getRefreshTokenKey(uuid), value: refreshToken);

  //   await storage.delete(key: getTokenKey());
  //   await storage.delete(key: getRefreshTokenKey());
  // }

  Future<({String? refreshToken, String? token})> getTokens([
    String? uuid,
  ]) async {
    // debugPrint('[i] getTokens');

    var storage = ref.read(secureStorageProvider);
    uuid ??= await storage.read(key: uuidKey);
    var token = await storage.read(key: getTokenKey(uuid));
    var refreshToken = await storage.read(key: getRefreshTokenKey(uuid));

    return (token: token, refreshToken: refreshToken);
  }

  Future<String?> getToken() async {
    var storage = ref.read(secureStorageProvider);

    var uuid = await storage.read(key: uuidKey);

    var r = await storage.read(key: getTokenKey(uuid));
    // debugPrint('[i] getToken: $uuid $r');

    return r;
  }

  Future<String?> getRefreshToken() async {
    var storage = ref.read(secureStorageProvider);
    var uuid = await storage.read(key: uuidKey);
    var r = await storage.read(key: getRefreshTokenKey(uuid));
    // debugPrint('[i] getRefreshToken: $r');

    return r;
  }

  Future<void> deleteTokens() async {
    // debugPrint('[i] deleteTokens');

    var storage = ref.read(secureStorageProvider);
    var uuid = await storage.read(key: uuidKey);

    if (uuid != null) {
      await storage.delete(key: getTokenKey());
      await storage.delete(key: getRefreshTokenKey());
    }

    await storage.delete(key: getTokenKey(uuid));
    await storage.delete(key: getRefreshTokenKey(uuid));
  }

  Future<void> deleteUuid() async {
    // debugPrint('[i] deleteUuid');
    var storage = ref.read(secureStorageProvider);
    await storage.delete(key: uuidKey);
  }

  Future<String?> getAccountUuid() async {
    // debugPrint('[i] getAccountUuid');

    var storage = ref.read(secureStorageProvider);
    var uuid = await storage.read(key: uuidKey);

    return storage.read(key: getAccountUuidKey(uuid));
  }

  Future<String?> getUuid() {
    // debugPrint('[i] getUuid');

    var storage = ref.read(secureStorageProvider);
    return storage.read(key: uuidKey);
  }

  Future<void> setTokenWithUuid(String uuid, TokenOut r) async {
    var storage = ref.read(secureStorageProvider);

    // debugPrint('[i] setTokenWithUuid $uuid');

    await storage.write(key: uuidKey, value: uuid);
    await storage.write(key: getTokenKey(uuid), value: r.accessToken);
    await storage.write(key: getRefreshTokenKey(uuid), value: r.refreshToken);
  }

  Future<void> setTokens(TokenOut r) async {
    var storage = ref.read(secureStorageProvider);

    // debugPrint('[i] setTokens');

    await storage.write(key: getTokenKey(), value: r.accessToken);
    await storage.write(key: getRefreshTokenKey(), value: r.refreshToken);
  }

  Future<void> switchUser(String uuid) async {
    // debugPrint('[i] switchUser: $uuid');

    var storage = ref.read(secureStorageProvider);
    await storage.write(key: uuidKey, value: uuid);
  }

  Future<void> removeUuid(String uuid) async {
    var storage = ref.read(secureStorageProvider);

    await storage.delete(key: uuid);
    await storage.delete(key: getTokenKey(uuid));
    await storage.delete(key: getRefreshTokenKey(uuid));

    var uuids = await storage.read(key: 'uuids');
    var uuidValues = jsonDecode(uuids ?? '[]') as List;
    uuidValues.remove(uuid);
    await storage.write(key: 'uuids', value: jsonEncode(uuidValues));
  }
}
