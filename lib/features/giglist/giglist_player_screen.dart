import 'package:better_player_plus/better_player_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/giglist/providers/giglist_player_controller.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/custom_rectangular_slider_thumb.dart';
import 'package:mobile_gigger_app/models/gig_list_media.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';

class GiglistPlayerScreen extends ConsumerStatefulWidget {
  const GiglistPlayerScreen({
    super.key,
    this.cdnUrl,
    required this.data,
    required this.isFromOwn,
    required this.giglist,
  });

  final String? cdnUrl;
  final GigListMedia data;
  final GigListOut giglist;
  final bool isFromOwn;

  @override
  ConsumerState<GiglistPlayerScreen> createState() =>
      _GiglistPlayerScreenState();
}

class _GiglistPlayerScreenState extends ConsumerState<GiglistPlayerScreen> {
  BetterPlayerController? controller;

  @override
  void initState() {
    super.initState();
    if (!widget.data.isVideo) return;

    controller = BetterPlayerController(
      BetterPlayerConfiguration(
        looping: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
          showControlsOnInitialize: false,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(
        '${widget.cdnUrl}/${widget.data.mediaUrl}',
        cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true),
        bufferingConfiguration: BetterPlayerBufferingConfiguration(
          minBufferMs: 5000,
          maxBufferMs: 10000,
          bufferForPlaybackMs: 2000,
          bufferForPlaybackAfterRebufferMs: 3000,
        ),
      ),
    );

    controller!.addEventsListener(eventListener);
  }

  @override
  void dispose() {
    controller?.removeEventsListener(eventListener);
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(giglistPlayerControllerProvider);

    if (widget.data.isVideo) {
      if (controller == null) return SizedBox();

      return Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onPanDown:
                  controller!.isVideoInitialized() == false ? null : onPanDown,
              onPanEnd:
                  controller!.isVideoInitialized() == false ? null : onPanEnd,
              child: Container(
                color: colorBlack1A,
                child: controller!.isVideoInitialized() == false
                    ? CircularLoading()
                    : BetterPlayer(controller: controller!),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.93),
                    colorTransparent,
                    colorTransparent,
                    Color.fromRGBO(0, 0, 0, 0.93),
                  ],
                  stops: [0, .2, .8, 1],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        overlayShape: SliderComponentShape.noOverlay,
                        trackHeight: 6,
                        thumbShape: CustomRectangularSliderThumb(
                          thumbRadius: 4,
                          thumbHeight: 16,
                          thumbColor: Colors.white,
                          borderRadius: 0,
                        ),
                      ),
                      child: Slider(
                        max: controller!.videoPlayerController?.value.duration
                                ?.inSeconds
                                .toDouble() ??
                            0,
                        value: controller!
                                .videoPlayerController?.value.position.inSeconds
                                .toDouble() ??
                            0,
                        activeColor: Colors.red,
                        inactiveColor: Colors.grey,
                        onChanged: (value) async {
                          await controller!.pause();
                          await controller!
                              .seekTo(Duration(seconds: value.toInt()));
                          await controller!.play();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  InkWell(
                    onTap: () {
                      ref
                          .read(giglistPlayerControllerProvider.notifier)
                          .toggleMute();
                    },
                    child: Icon(
                      state.isMute ? Icons.volume_mute : Icons.volume_up,
                      size: 20,
                      color: Colors.white,
                      shadows: [BoxShadow(blurRadius: 10)],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 0, 0, 0.93),
            colorTransparent,
            colorTransparent,
            Color.fromRGBO(0, 0, 0, 0.93),
          ],
          stops: [0, .2, .8, 1],
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
            '${widget.cdnUrl}/${widget.data.mediaUrl}',
          ),
        ),
      ),
    );
  }

  Future<void> onPanDown(_) async {
    await controller?.pause();
  }

  Future<void> onPanEnd(_) async {
    await controller?.play();
  }

  void eventListener(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (controller!.videoPlayerController != null) {
        if (!(controller!.isPlaying() ?? false)) {
          controller!.play();
        }

        controller!.setOverriddenAspectRatio(
          controller!.videoPlayerController!.value.aspectRatio,
        );
      }
    }

    setState(() {});
  }
}
