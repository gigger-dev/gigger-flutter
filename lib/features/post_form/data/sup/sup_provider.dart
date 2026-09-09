// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/sup/sup_repo.dart';
import '../../../../../gen/sup/c3_vw_x2_nsa_w_vud_a.dart';
import 'sup_repo_impl.dart';
import '../../../../core/providers/dio_provider.dart';

part 'sup_provider.g.dart';

@Riverpod(keepAlive: true)
U3VwQ2xpZW50 supClient(Ref ref) {
  return U3VwQ2xpZW50(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
U3VwUmVwbw supRepo(Ref ref) {
  return U3VwUmVwb0ltcGw(ref.watch(supClientProvider));
}
