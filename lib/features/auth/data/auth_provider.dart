// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/auth_repo.dart';
import '../../../../../gen/yxv0a_f9jb_gllbn_q.dart';
import 'auth_repo_impl.dart';
import '../../../core/providers/dio_provider.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
QXV0aENsaWVudA authClient(Ref ref) {
  return QXV0aENsaWVudA(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
QXV0aFJlcG8 authRepo(Ref ref) {
  return QXV0aFJlcG9JbXBs(ref.watch(authClientProvider));
}
