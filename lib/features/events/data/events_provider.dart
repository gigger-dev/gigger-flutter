// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/events_repo.dart';
import '../../../../../gen/zx_zlbn_rz_x2_nsa_w_vud_a.dart';
import 'events_repo_impl.dart';
import '../../../core/providers/dio_provider.dart';

part 'events_provider.g.dart';

@Riverpod(keepAlive: true)
RXZlbnRzQ2xpZW50 eventsClient(Ref ref) {
  return RXZlbnRzQ2xpZW50(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
RXZlbnRzUmVwbw eventsRepo(Ref ref) {
  return RXZlbnRzUmVwb0ltcGw(ref.watch(eventsClientProvider));
}
