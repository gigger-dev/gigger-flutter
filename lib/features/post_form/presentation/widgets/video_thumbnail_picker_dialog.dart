import 'dart:io';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/loading_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailPickerDialog extends StatefulWidget {
  const VideoThumbnailPickerDialog(this.file, {super.key});

  final File file;

  @override
  State<VideoThumbnailPickerDialog> createState() =>
      _VideoThumbnailPickerDialogState();
}

class _VideoThumbnailPickerDialogState
    extends State<VideoThumbnailPickerDialog> {
  late BetterPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = BetterPlayerController(
      BetterPlayerConfiguration(
        looping: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
          showControlsOnInitialize: false,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource.file(
        widget.file.path,
        cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true),
      ),
    );

    controller.addEventsListener(eventListener);
  }

  @override
  void dispose() {
    controller.removeEventsListener(eventListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: colorBlack,
      child: Scaffold(
        backgroundColor: colorBlack,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colorBlack,
          automaticallyImplyLeading: false,
          title: const TextViewWidget(text: 'Upload'),
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(Icons.clear),
          ),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_horiz),
              itemBuilder: (context) => [],
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.isVideoInitialized() == false
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : AspectRatio(
                          aspectRatio: controller
                              .videoPlayerController!.value.aspectRatio,
                          child: BetterPlayer(controller: controller)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        overlayShape: SliderComponentShape.noOverlay,
                      ),
                      child: Slider(
                        max: controller.videoPlayerController?.value.duration
                                ?.inSeconds
                                .toDouble() ??
                            0,
                        value: controller
                                .videoPlayerController?.value.position.inSeconds
                                .toDouble() ??
                            0,
                        activeColor: Colors.red,
                        inactiveColor: Colors.grey,
                        onChanged: (value) async {
                          await controller
                              .seekTo(Duration(seconds: value.toInt()));

                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    const TextViewWidget(text: 'Scroll and choose frame'),
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LoadingButton(
                        title: 'Select frame for cover',
                        isLoading: false,
                        onPressed: onSave,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onSave() async {
    var thumbnailImageFile = await getThumbnail(
      widget.file.path,
      controller.videoPlayerController!.value.position.inMilliseconds,
    );

    if (thumbnailImageFile == null || !mounted) return;

    var size = controller.videoPlayerController!.value.size!;

    context.pop([thumbnailImageFile, size.height < size.width]);
  }

  void eventListener(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (controller.videoPlayerController != null) {
        controller.setOverriddenAspectRatio(
          controller.videoPlayerController!.value.aspectRatio,
        );
      }
    }

    if (mounted) setState(() {});
  }
}

Future<File?> getThumbnail(String path, int timeMs) async {
  var _uint8list = await VideoThumbnail.thumbnailData(
    video: path,
    quality: 100,
    timeMs: timeMs,
    imageFormat: ImageFormat.JPEG,
  );

  if (_uint8list == null) return null;

  var name = p.basenameWithoutExtension(path);

  final tempDir = await getTemporaryDirectory();
  var thumbnailImageFile = await File('${tempDir.path}/$name.jpeg').create();
  await thumbnailImageFile.writeAsBytes(_uint8list);

  return thumbnailImageFile;
}
