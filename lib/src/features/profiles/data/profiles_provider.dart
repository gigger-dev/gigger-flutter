// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/profiles_repo.dart';
import '../../../../../gen/c_h_jv_zmls_zx_nf_y2xp_zw50.dart';
import 'profiles_repo_impl.dart';
import 'package:mobile_gigger_app/core/providers/dio_provider.dart';

part 'profiles_provider.g.dart';

@Riverpod(keepAlive: true)
UHJvZmlsZXNDbGllbnQ profilesClient(Ref ref) {
  return UHJvZmlsZXNDbGllbnQ(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
UHJvZmlsZXNSZXBv profilesRepo(Ref ref) {
  return UHJvZmlsZXNSZXBvSW1wbA(ref.watch(profilesClientProvider));
}
