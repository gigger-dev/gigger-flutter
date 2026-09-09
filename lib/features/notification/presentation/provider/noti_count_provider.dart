import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/noti_read_controller.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/notification_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'noti_count_provider.g.dart';

@Riverpod(keepAlive: true)
int notiCount(Ref ref) {
  var items = ref.watch(notificationControllerProvider).valueOrNull ?? [];
  var reads = ref.watch(notiReadControllerProvider).valueOrNull ?? [];

  return items.where((e) => !reads.contains(jsonEncode(e.toJson()))).length;
}
