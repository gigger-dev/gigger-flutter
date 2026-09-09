import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/consts/const.dart';
import 'package:mobile_gigger_app/core/helpers/chat_helper.dart';
import 'package:mobile_gigger_app/core/providers/dio_provider.dart';
import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/core/providers/token_controller.dart';
import 'package:mobile_gigger_app/core/route/router_config.dart';
import 'package:mobile_gigger_app/core/utils/get_device_uuid.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/auth/data/auth_provider.dart';
import 'package:mobile_gigger_app/features/auth/domain/auth_use_case.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/switch_user_controller.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/notification_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/data/settings_provider.dart';
import 'package:mobile_gigger_app/features/settings/domain/settings_use_case.dart';
import 'package:mobile_gigger_app/gen/yxv0a_f9jb_gllbn_q.dart';
import 'package:mobile_gigger_app/models/account_out.dart';
import 'package:mobile_gigger_app/models/forgot_password.dart';
import 'package:mobile_gigger_app/models/sign_in.dart';
import 'package:mobile_gigger_app/models/sign_up.dart';
import 'package:mobile_gigger_app/models/token_out.dart';
import 'package:mobile_gigger_app/models/validation_error.dart';
import 'package:mobile_gigger_app/models/verify_otp.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.freezed.dart';
part 'auth_controller.g.dart';

@riverpod
Future<TokenOut> refreshToken(Ref ref, String token) {
  var dio = Dio(BaseOptions(baseUrl: baseUrl));
  dio.interceptors.add(LogInterceptor(
    requestBody: kDebugMode,
    responseBody: kDebugMode,
    requestHeader: kDebugMode,
    responseHeader: kDebugMode,
  ));
  return QXV0aENsaWVudA(dio)
      .cG9zdEFwaVYxQWNjb3VudHnszwZyZXNoVg9rZw5z(refreshToken: token);
}

@riverpod
Future<AccountOut> me(Ref ref, String token) {
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
    onResponse: (r, handler) async {
      if (r.statusCode == 401) {
        var token =
            await ref.read(authControllerProvider.notifier).refreshToken();
        if (token == null) {
          return ref.read(authControllerProvider.notifier).deleteAndReset();
        }

        var option = r.requestOptions;
        option.headers['authorization'] = 'Bearer $token';
        return handler.resolve(await dio.fetch(option));
      }

      return handler.next(r);
    },
  ));
  return QXV0aENsaWVudA(dio).z2V0QXBpVjFby2NvdW50c01l();
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AuthState> build() async {
    var s = AuthState.init();

    var tokens = await ref.read(tokenControllerProvider.notifier).getTokens();

    await Future.delayed(Duration(seconds: 2));

    var token = tokens.token;
    var refreshToken = tokens.refreshToken;

    Completer<AccountOut?> me = Completer<AccountOut?>();

    if (tokens.token != null) {
      while (true) {
        try {
          var r = await ref.read(meProvider(token!).future);
          me.complete(r);
          break;
        } catch (_) {
          var r = await ref.read(refreshTokenProvider(refreshToken!).future);

          token = r.accessToken;
          refreshToken = r.refreshToken;

          await ref.read(tokenControllerProvider.notifier).setTokens(r);

          continue;
        }
      }

      s = s.copyWith(
        token: token,
        me: await me.future,
        refreshToken: refreshToken,
      );
    }

    return s;
  }

  Future<void> login(SignIn data) async {
    try {
      var repo = ref.read(authRepoProvider);
      var r = await postApiV1AccountsSignInUseCase(repo: repo, body: data);

      var storage = ref.read(secureStorageProvider);
      await storage.write(key: 'session', value: r.sessionToken);
      await storage.delete(key: 'noti_token');

      // await ref.read(tokenControllerProvider.notifier).deleteTokens();

      state = AsyncData(
        state.value!.copyWith(
          isLogin: true,
          errorOb: null,
          email: r.email,
          formErrorOb: null,
          session: r.sessionToken,
        ),
      );
    } on HttpValidationException catch (e) {
      var error = e.error as List<ValidationError>?;
      state = AsyncData(state.value!.copyWith(
        isLoading: false,
        formErrorOb: error,
      ));

      if (e.message != null) showErrorSheet(e.message);
    } catch (e) {
      state = AsyncData(state.value!.copyWith(isLoading: false));
    }
  }

  Future<void> register(SignUp body) async {
    try {
      state = AsyncData(state.value!.copyWith(isLoading: true));

      var r = await postApiV1AccountsRegisterUseCase(
        repo: ref.read(authRepoProvider),
        body: body,
      );

      var storage = ref.read(secureStorageProvider);
      await storage.write(key: 'session', value: r.sessionToken);
      await storage.delete(key: 'noti_token');

      await ref.read(tokenControllerProvider.notifier).deleteTokens();

      state = AsyncData(state.value!.copyWith(
        errorOb: null,
        isLogin: false,
        email: r.email,
        formErrorOb: null,
        session: r.sessionToken,
        username: body.username,
      ));

      state = AsyncData(state.value!.copyWith(isLoading: false));
    } on HttpValidationException catch (e) {
      var error = e.error as List<ValidationError>?;
      state = AsyncData(
        state.value!.copyWith(isLoading: false, formErrorOb: error),
      );

      if (e.message != null) showErrorSheet(e.message);
    } catch (e) {
      state = AsyncData(state.value!.copyWith(isLoading: false));
    }
  }

  Future<void> deleteAccount() async {
    var repo = ref.read(authRepoProvider);
    await postApiV1AccountsDevDeleteAccountUseCase(
      repo: repo,
      email: state.value!.email,
    );
    await logout();
  }

  Future<void> redirectToProfileSetup() async {
    await me();

    var storage = ref.read(secureStorageProvider);
    var uuid = await storage.read(key: uuidKey);
    if (uuid != null) {
      await storage.delete(key: uuidKey);
      await storage.delete(key: uuid);
    }

    var s = state.value!;

    state = AsyncData(AuthState.init().copyWith(
      token: s.token,
      session: s.session,
      email: s.me?.email ?? s.email,
      username: s.me?.username ?? s.username,
    ));
  }

  Future<void> logout() async {
    try {
      var deviceUuid = await getDeviceUuid();

      await deleteApiV1ConfigLogoutUseCase(
        deviceUuid: deviceUuid,
        repo: ref.read(settingsRepoProvider),
      );

      var context = rootNavigatorKey.currentState!.context;
      if (context.mounted) await ChatHelper.disconnectUser(context);
    } catch (_) {}

    var storage = ref.read(secureStorageProvider);
    var uuid = await storage.read(key: uuidKey);
    if (uuid != null) {
      await storage.delete(key: 'session');
      await storage.delete(key: 'noti_token');
    }

    // await ref.read(tokenControllerProvider.notifier).deleteTokens();
    await ref.read(tokenControllerProvider.notifier).deleteUuid();

    state = AsyncData(AuthState.init());
  }

  Future<String?> refreshToken({
    bool isSwitchUser = false,
    bool resetState = false,
  }) async {
    var token =
        await ref.read(tokenControllerProvider.notifier).getRefreshToken();

    if (token == null) return null;

    var r = await ref.read(refreshTokenProvider(token).future);

    // if (r.refreshToken == token || r.accessToken == token) return null;

    return setToken(
      r,
      resetState: resetState,
      isSwitchUser: isSwitchUser,
    );
    // try {} catch (e) {
    //   Toast.error(e.toString());
    //   return null;
    // }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final r = await postApiV1AccountsVerifyOtpUseCase(
        repo: ref.read(authRepoProvider),
        body: VerifyOtp(email: state.value!.email, otp: otp),
      );

      await setToken(r);
    } on HttpValidationException catch (e) {
      var error = e.error as List<ValidationError>?;
      state = AsyncData(state.value!.copyWith(
        isLoading: false,
        formErrorOb: error,
      ));

      if (e.message != null) showErrorSheet(e.message);
    }
  }

  Future<String> setToken(
    TokenOut r, {
    bool isSwitchUser = false,
    bool resetState = false,
  }) async {
    var s = await future;

    AccountOut? me;

    if (s.isLogin || isSwitchUser) {
      me = await ref.read(meProvider(r.accessToken).future);

      var uuid = await ref.read(profileControllerProvider.notifier).getProfile(
            accountUuid: me!.uuid,
            token: r.accessToken,
            isSaveUser: true,
          );

      await ref
          .read(tokenControllerProvider.notifier)
          .setTokenWithUuid(uuid!, r);

      ref.read(notificationControllerProvider.notifier).refresh();
    } else {
      await ref.read(tokenControllerProvider.notifier).setTokens(r);
    }

    if (resetState) resetAllState();

    state = AsyncData(s.copyWith(
      me: me,
      errorOb: null,
      formErrorOb: null,
      token: r.accessToken,
      isRefreshToken: false,
      refreshToken: r.refreshToken,
    ));

    return r.accessToken;
  }

  Future<void> setMe(AccountOut out) async {
    await ref.read(tokenControllerProvider.notifier).setAccountUuid(out.uuid);
    state = AsyncData(state.value!.copyWith(me: out));
  }

  Future<void> me() async {
    await update((state) async {
      if (state.token == null) return state;

      var r = await getApiV1AccountsMeUseCase(ref.read(authRepoProvider));
      await ref.read(tokenControllerProvider.notifier).setAccountUuid(r.uuid);
      return state.copyWith(me: r);
    });
  }

  Future<void> clearErrorOb() async {
    await update((state) => state.copyWith(errorOb: null));
  }

  void birthday(DateTime date) {
    state = AsyncData(state.value!.copyWith(birthday: date));
  }

  void isInterestFinish(bool value) {
    state = AsyncData(state.value!.copyWith(isInterestFinish: value));
  }

  Future<void> redirectToSelectInterset() async {
    var storage = ref.read(secureStorageProvider);
    var uuid = await storage.read(key: uuidKey);
    if (uuid != null) {
      await storage.delete(key: uuidKey);
      await storage.delete(key: uuid);
    }

    var s = state.value!;

    state = AsyncData(AuthState.init().copyWith(
      token: s.token,
      session: s.session,
      refreshToken: null,
      email: s.me?.email ?? s.email,
      username: s.me?.username ?? s.username,
    ));
  }

  void isLoading(bool value) {
    state = AsyncData(state.value!.copyWith(isLoading: value));
  }

  Future<void> deleteAndReset() async {
    await ref.read(tokenControllerProvider.notifier).deleteTokens();
    state = AsyncData(AuthState.init());
  }

  void reset() {
    state = AsyncData(AuthState.init());
  }

  Future<void> forgotPassword(ForgotPassword body) async {
    try {
      var repo = ref.read(authRepoProvider);
      var r =
          await postApiV1AccountsForgotPasswordUseCase(body: body, repo: repo);

      await setToken(r);

      state = AsyncData(state.value!.copyWith(isForgotPassword: false));
    } on HttpValidationException catch (e) {
      if (e.message != null) Toast.error(e.message!);

      var error = e.error as List<ValidationError>?;
      state = AsyncData(state.value!.copyWith(
        isLoading: false,
        errorOb: e.message,
        formErrorOb: error,
      ));
    }
  }

  Future<void> forgotPasswordRequest(String email) async {
    try {
      var repo = ref.read(authRepoProvider);
      var r = await postApiV1AccountsForgotPasswordRequestUseCase(
        repo: repo,
        email: email,
      );

      var storage = ref.read(secureStorageProvider);
      await storage.write(key: 'session', value: r.sessionToken);

      state = AsyncData(
        state.value!.copyWith(
          email: r.email,
          session: r.sessionToken,
          isForgotPassword: true,
          errorOb: null,
          formErrorOb: null,
        ),
      );
    } on HttpValidationException catch (e) {
      if (e.message != null) Toast.error(e.message!);

      var error = e.error as List<ValidationError>?;
      state = AsyncData(state.value!.copyWith(
        isLoading: false,
        errorOb: e.message,
        formErrorOb: error,
      ));
    }
  }

  void redirectToLogin() {
    state = AsyncData(AuthState.init());
  }

  void showErrorSheet(String? message) {
    var context = rootNavigatorKey.currentState!.context;

    if (!context.mounted) return;

    SheetUtils.showSimpleSheet(
      context: context,
      child: SizedBox(
        height: .2.sh,
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 1,
              width: 60,
              color: colorWhite,
            ),
            Expanded(
              child: Center(child: TextViewWidget(text: '$message')),
            ),
          ],
        ),
      ),
    );
  }
}

@Freezed(fromJson: false, toJson: false)
class AuthState with _$AuthState {
  factory AuthState({
    String? token,
    AccountOut? me,
    String? session,
    String? errorOb,
    DateTime? birthday,
    String? refreshToken,
    required String email,
    required bool isLogin,
    required bool isLoading,
    required String username,
    required bool isRefreshToken,
    required bool isInterestFinish,
    required bool isForgotPassword,
    List<ValidationError>? formErrorOb,
  }) = _AuthState;

  factory AuthState.init() => AuthState(
        email: '',
        username: '',
        isLogin: true,
        isLoading: false,
        isRefreshToken: false,
        isInterestFinish: false,
        isForgotPassword: false,
      );
}

void resetAllState() {
  var elements = ProviderScope.containerOf(
    rootNavigatorKey.currentState!.context,
    listen: false,
  ).getAllProviderElements();

  for (var e in elements) {
    if (e.provider
        is AutoDisposeAsyncNotifierProvider<SwitchUserController, String?>) {
      continue;
    }
    e.invalidateSelf();
  }
}
