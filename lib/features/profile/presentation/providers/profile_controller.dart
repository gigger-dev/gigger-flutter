import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/const.dart';
import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/core/providers/token_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/artist_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/giglist_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/gen/c_h_jv_zmls_zx_nf_y2xp_zw50.dart';
import 'package:mobile_gigger_app/models/account_out.dart';
import 'package:mobile_gigger_app/models/profile_in.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/models/profile_update.dart';
import 'package:mobile_gigger_app/models/token_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@riverpod
Future<ProfileOut> getProfile(
  Ref ref,
  String accountUuid,
  String token,
) {
  var dio = Dio(BaseOptions(baseUrl: baseUrl));
  dio.interceptors.add(LogInterceptor(
    requestBody: kDebugMode,
    responseBody: kDebugMode,
    requestHeader: kDebugMode,
    responseHeader: kDebugMode,
  ));
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['authorization'] = 'Bearer $token';
      return handler.next(options);
    },
  ));
  return UHJvZmlsZXNDbGllbnQ(dio)
      .z2V0QXBpVjFQcm9maWxlcw(accountUuid: accountUuid);
}

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  @override
  Future<ProfileOut?> build() => _getProfile();

  Future<ProfileOut?> _getProfile() async {
    var storage = ref.read(secureStorageProvider);

    var uuid = await storage.read(key: uuidKey);
    if (uuid == null) return null;

    var r = await storage.read(key: uuid);
    if (r == null) return null;

    return ProfileOut.fromJson(jsonDecode(r));
  }

  Future<ProfileOut?> reset() async {
    var r = await _getProfile();
    if (r == null) {
      state = const AsyncData(null);
      return null;
    }

    state = AsyncData(r);
    return r;
  }

  Future<void> createProfile(
    ProfileIn model,
    AccountOut me,
    Function() onSuccess,
    ValueChanged<String> onError,
  ) async {
    try {
      var r = await postApiV1ProfilesUseCase(
        body: model,
        repo: ref.read(profileRepoProvider),
      );
      onSuccess();

      var tokens = await ref.read(tokenControllerProvider.notifier).getTokens();
      await ref.read(tokenControllerProvider.notifier).setTokenWithUuid(
            r.uuid,
            TokenOut(
              accessToken: tokens.token!,
              refreshToken: tokens.refreshToken!,
            ),
          );

      await saveUser(r);
      ref.read(authControllerProvider.notifier).setMe(me);
    } catch (e) {
      onError('$e');
    }
  }

  Future<String?> getProfile({
    String? accountUuid,
    String? token,
    bool isSaveUser = false,
  }) async {
    try {
      accountUuid ??=
          await ref.read(tokenControllerProvider.notifier).getAccountUuid();
      token ??= await ref.read(tokenControllerProvider.notifier).getToken();

      if (accountUuid == null || token == null) return null;

      var r = await ref.read(getProfileProvider(accountUuid, token).future);

      var config = await ref.read(configProvider.future);
      var cdnUrl = config?.cdnUrl ?? '';

      await saveProfileData(r);

      if (isSaveUser) await saveUser(r);

      await DefaultCacheManager().downloadFile('$cdnUrl/${r.coverMedia}');

      state = AsyncData(r);

      return r.uuid;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateProfile(ProfileUpdate profile) async {
    try {
      var r = await patchApiV1ProfilesProfileUuidUseCase(
        body: profile,
        profileUuid: profile.uuid,
        repo: ref.read(profileRepoProvider),
      );

      await saveProfileData(r);
      state = AsyncData(r);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> selectUser(ProfileOut r) async {
    await ref.read(tokenControllerProvider.notifier).switchUser(r.uuid);

    await ref
        .read(authControllerProvider.notifier)
        .refreshToken(isSwitchUser: true);

    state = AsyncData(r);

    await ref.read(artistControllerProvider.notifier).refresh();
    await ref.read(recommendedVideoControllerProvider.notifier).refresh();
    await ref.read(giglistControllerProvider.notifier).refresh();
  }

  Future<void> saveProfileData(ProfileOut r) async {
    var storage = ref.read(secureStorageProvider);
    await storage.write(key: r.uuid, value: jsonEncode(r.toJson()));
  }

  Future<void> saveUser(ProfileOut r) async {
    await ref.read(tokenControllerProvider.notifier).setUuid(r.uuid);

    var storage = ref.read(secureStorageProvider);

    var uuids = await storage.read(key: 'uuids');
    var uuidValues = jsonDecode(uuids ?? '[]') as List;
    if (!uuidValues.contains(r.uuid)) uuidValues.add(r.uuid);

    await storage.write(key: 'uuids', value: jsonEncode(uuidValues));
    await storage.write(key: r.uuid, value: jsonEncode(r.toJson()));

    state = AsyncData(r);
  }

  Future<void> togglePrivate() async {
    try {
      var user = state.value!;

      var r = await postApiV1ProfilesProfileUuidTogglePrivateProfileModeUseCase(
        profileUuid: user.uuid,
        isPrivate: !user.isPrivateProfile,
        repo: ref.read(profileRepoProvider),
      );

      await saveProfileData(r);
      state = AsyncData(r);
    } catch (_) {}
  }
}
