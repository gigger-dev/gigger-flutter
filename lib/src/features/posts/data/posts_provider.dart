// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/posts_repo.dart';
import '../../../../../gen/c_g9zd_h_nf_y2xp_zw50.dart';
import 'posts_repo_impl.dart';
import 'package:mobile_gigger_app/core/providers/dio_provider.dart';

part 'posts_provider.g.dart';

@Riverpod(keepAlive: true)
UG9zdHNDbGllbnQ postsClient(Ref ref) {
  return UG9zdHNDbGllbnQ(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
UG9zdHNSZXBv postsRepo(Ref ref) {
  return UG9zdHNSZXBvSW1wbA(ref.watch(postsClientProvider));
}
