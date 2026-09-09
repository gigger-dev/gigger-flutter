// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/gig_lists/gig_lists_repo.dart';
import '../../../../../gen/gig_lists/z2ln_x2xpc3_rz_x2_nsa_w_vud_a.dart';
import 'gig_lists_repo_impl.dart';
import '../../../../core/providers/dio_provider.dart';

part 'gig_lists_provider.g.dart';

@Riverpod(keepAlive: true)
R2lnTGlzdHNDbGllbnQ gigListsClient(Ref ref) {
  return R2lnTGlzdHNDbGllbnQ(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
R2lnTGlzdHNSZXBv gigListsRepo(Ref ref) {
  return R2lnTGlzdHNSZXBvSW1wbA(ref.watch(gigListsClientProvider));
}
