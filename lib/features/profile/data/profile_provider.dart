// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/gen/c_h_jv_zmls_zx_nf_y2xp_zw50.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/profile_repo.dart';
import 'profile_repo_impl.dart';
import '../../../core/providers/dio_provider.dart';

part 'profile_provider.g.dart';

@Riverpod(keepAlive: true)
UHJvZmlsZXNDbGllbnQ profileClient(Ref ref) {
  return UHJvZmlsZXNDbGllbnQ(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
UHJvZmlsZVJlcG8 profileRepo(Ref ref) {
  return UHJvZmlsZVJlcG9JbXBs(ref.watch(profileClientProvider));
}
