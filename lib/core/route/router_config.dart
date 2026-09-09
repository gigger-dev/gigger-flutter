import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_config.g.dart';

GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey();

@Riverpod(keepAlive: true)
GoRouter routerConfig(Ref ref) {
  final authState = ValueNotifier<AuthState?>(null);

  ref
    ..onDispose(authState.dispose)
    ..listen(
      authControllerProvider
          .select((v) => v.whenData((v) => authState.value = v)),
      (previous, next) => authState.value = next.value,
    );

  return GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: true,
    refreshListenable: authState,
    navigatorKey: rootNavigatorKey,
    initialLocation: LoginRoute().location,
    redirect: (context, state) {
      var resp = authState.value;

      if (resp?.isForgotPassword == true && resp?.token != null) {
        return ForgotRoute(initialPage: 1).location;
      }

      // if user is logged in
      if (resp?.token != null &&
          resp?.refreshToken != null &&
          resp?.me != null) {
        if (state.fullPath!.contains(MainRoute().location)) return null;
        if (state.fullPath!.contains('/availability')) return null;

        return MainRoute().location;
      }

      // else user null
      if (resp?.me == null && resp?.session == null && resp?.token == null) {
        if (state.fullPath == RegisterRoute().location) return null;
        if (state.fullPath == ForgotRoute().location) return null;
        if (state.matchedLocation.contains(LoginRoute().location)) return null;

        return LoginRoute().location;
      }

      // after select interest
      if (resp?.isInterestFinish == true) {
        if (state.fullPath == '/availability') return null;

        return ProfileSetupRoute().location;
      }

      // after otp verification
      if (resp?.token != null) {
        return InterestRoute().location;
      }

      // after user login or register
      if (resp?.session != null) {
        return OTPRoute().location;
      }

      return null;
    },
  );
}
