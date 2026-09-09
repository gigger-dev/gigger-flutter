import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';

Future<double?> getVideoAspectRatio(File file) async {
  var controller = BetterPlayerController(BetterPlayerConfiguration());

  await controller.setupDataSource(BetterPlayerDataSource.file(file.path));

  final size = controller.videoPlayerController?.value.size;

  if (size == null) return null;

  controller.dispose();
  return size.width / size.height;
}
