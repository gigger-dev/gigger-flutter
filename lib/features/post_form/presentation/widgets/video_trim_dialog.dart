import 'dart:async';
import 'dart:io';

import 'package:ffmpeg_kit_flutter_new_min/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/get_video_aspect_ratio.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_editor/video_editor.dart';

typedef AsyncOrValueChanged<T> = FutureOr<File?> Function(T value);

class VideoTrimDialog extends StatefulWidget {
  const VideoTrimDialog(
    this.file, {
    super.key,
    this.maxDuration = 20,
    this.onCallBack,
  });

  final File file;
  final int maxDuration;
  final AsyncOrValueChanged<File>? onCallBack;

  @override
  State<VideoTrimDialog> createState() => _VideoTrimDialogState();
}

class _VideoTrimDialogState extends State<VideoTrimDialog> {
  final double height = 60;

  late VideoEditorController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoEditorController.file(
      widget.file,
      maxDuration: Duration(seconds: widget.maxDuration),
    );
    setController();
  }

  Future<void> setController() async {
    var aspectRatio = await getVideoAspectRatio(widget.file);

    _controller.initialize(aspectRatio: aspectRatio).then((_) {
      setState(() {});
    }).catchError((error) {
      if (!mounted) return;
      context.pop();
    }, test: (e) => e is VideoMinDurationError);
  }

  @override
  void dispose() {
    _controller.dispose();
    FFmpegKit.cancel();
    super.dispose();
  }

  String formatter(Duration duration) => [
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(':');

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: colorBlack,
      child: Scaffold(
        backgroundColor: colorBlack,
        appBar: AppBar(
          backgroundColor: colorBlack,
          actions: [
            IconButton(
              onPressed: onSave,
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        body: !_controller.initialized
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CropGridViewer.preview(controller: _controller),
                        AnimatedBuilder(
                          animation: _controller.video,
                          builder: (_, __) => AnimatedOpacity(
                            opacity: _controller.isPlaying ? 0 : 1,
                            duration: kThemeAnimationDuration,
                            child: GestureDetector(
                              onTap: _controller.video.play,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: Listenable.merge([
                          _controller,
                          _controller.video,
                        ]),
                        builder: (_, __) {
                          final int duration =
                              _controller.videoDuration.inSeconds;
                          final double pos =
                              _controller.trimPosition * duration;

                          return Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: height / 4),
                            child: Row(children: [
                              Text(formatter(Duration(seconds: pos.toInt()))),
                              const Expanded(child: SizedBox()),
                              AnimatedOpacity(
                                opacity: _controller.isTrimming ? 1 : 0,
                                duration: kThemeAnimationDuration,
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(formatter(_controller.startTrim)),
                                      const SizedBox(width: 10),
                                      Text(formatter(_controller.endTrim)),
                                    ]),
                              ),
                            ]),
                          );
                        },
                      ),
                      Container(
                        width: 1.sw,
                        margin: EdgeInsets.symmetric(vertical: height / 4),
                        child: TrimSlider(
                          controller: _controller,
                          height: height,
                          horizontalMargin: height / 4,
                          child: TrimTimeline(
                            controller: _controller,
                            padding: const EdgeInsets.only(top: 10),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }

  Future<void> onSave() async {
    _controller.video.pause();

    var overlayEntry = OverlayEntry(builder: (context) {
      return Positioned.fill(
        child: Container(
          color: colorBlack.withOpacity(.5),
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: colorRed,
              ),
              padding: const EdgeInsets.all(6),
              child: Transform.scale(
                scale: .6,
                child: const CircularProgressIndicator(color: colorWhite),
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context).insert(overlayEntry);

    try {
      final config = VideoFFmpegVideoEditorConfig(_controller);
      final FFmpegVideoEditorExecute execute = await config.getExecuteConfig();

      await FFmpegKit.executeAsync(execute.command, (session) async {
        final code = await session.getReturnCode();

        if (ReturnCode.isSuccess(code)) {
          var mediaInfo = await VideoCompress.compressVideo(
            execute.outputPath,
            deleteOrigin: true,
            quality: VideoQuality.HighestQuality,
          );

          var file = mediaInfo?.file;

          if (file == null) return;

          if (widget.onCallBack == null) {
            overlayEntry.remove();
            if (!mounted) return;
            context.pop(file);
            return;
          }

          var _file = await widget.onCallBack!(file);
          if (_file == null) {
            overlayEntry.remove();
            Toast.error('Gif convert error');
            return;
          }

          overlayEntry.remove();
          if (!mounted) return;
          context.pop(_file);
        } else {
          overlayEntry.remove();
        }
      });
    } catch (e) {
      overlayEntry.remove();
      Toast.error(e.toString());
    }

    // await _controller.exportVideo(
    //   onCompleted: (file) {
    //     overlayEntry.remove();
    //     context.pop(file);
    //   },
    //   onError: (p0, p1) {
    //     overlayEntry.remove();
    //     Toast.error(p0.toString());
    //   },
    // );
  }
}
