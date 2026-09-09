import 'package:better_player_plus/better_player_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class SupStoryItem extends StatefulWidget {
  const SupStoryItem(
      {super.key,
      required this.cdnUrl,
      required this.videoUrl,
      required this.thumbnailUrl});

  final String cdnUrl;
  final String videoUrl;
  final String thumbnailUrl;

  @override
  State<SupStoryItem> createState() => _SupStoryItemState();
}

class _SupStoryItemState extends State<SupStoryItem> {
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
      betterPlayerDataSource: BetterPlayerDataSource.network(
        '${widget.cdnUrl}/${widget.videoUrl}',
        cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true),
        bufferingConfiguration: BetterPlayerBufferingConfiguration(
          minBufferMs: 5000,
          maxBufferMs: 10000,
          bufferForPlaybackMs: 2000,
          bufferForPlaybackAfterRebufferMs: 3000,
        ),
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
    return SizedBox(
      height: 1.sh,
      child: ColoredBox(
        color: colorBlack,
        child: controller.videoPlayerController?.value == null
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: CachedNetworkImageProvider(
                      '${widget.cdnUrl}/${widget.thumbnailUrl}',
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: .6,
                  child: CircularProgressIndicator(),
                ),
              )
            : BetterPlayer(controller: controller),
      ),
    );
  }

  void eventListener(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (controller.videoPlayerController != null) {
        if (!(controller.isPlaying() ?? false)) {
          controller.play();
        }

        controller.setOverriddenAspectRatio(
          controller.videoPlayerController!.value.aspectRatio,
        );

        setState(() {});
      }
    }
  }
}
