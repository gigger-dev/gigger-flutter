// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/settings_repo.dart';
import '../../../../../gen/c2_v0d_glu_z3_nf_y2xp_zw50.dart';
import 'settings_repo_impl.dart';
import '../../../core/providers/dio_provider.dart';

part 'settings_provider.g.dart';

@Riverpod(keepAlive: true)
U2V0dGluZ3NDbGllbnQ settingsClient(Ref ref) {
  return U2V0dGluZ3NDbGllbnQ(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
U2V0dGluZ3NSZXBv settingsRepo(Ref ref) {
  return U2V0dGluZ3NSZXBvSW1wbA(ref.watch(settingsClientProvider));
}
