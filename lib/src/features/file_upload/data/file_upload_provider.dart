// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/file_upload_repo.dart';
import '../../../../../gen/zmls_zv91c_gxv_yw_rf_y2xp_zw50.dart';
import 'file_upload_repo_impl.dart';
import 'package:mobile_gigger_app/core/providers/dio_provider.dart';

part 'file_upload_provider.g.dart';

@Riverpod(keepAlive: true)
RmlsZVVwbG9hZENsaWVudA fileUploadClient(Ref ref) {
  return RmlsZVVwbG9hZENsaWVudA(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
RmlsZVVwbG9hZFJlcG8 fileUploadRepo(Ref ref) {
  return RmlsZVVwbG9hZFJlcG9JbXBs(ref.watch(fileUploadClientProvider));
}
