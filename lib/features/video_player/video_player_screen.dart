import 'package:flutter/material.dart' hide PageScrollPhysics;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/home/providers/artist_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/features/video_player/providers/video_controller.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/better_player_ui.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:preload_page_view/preload_page_view.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  const VideoPlayerScreen({
    super.key,
    required this.index,
    this.uuid,
  });

  final int index;
  final String? uuid;

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  PreloadPageController? controller;

  @override
  void initState() {
    super.initState();

    ref.read(artistControllerProvider);

    Future.delayed(Duration.zero, () {
      if (widget.uuid != null) {
        setItems(widget.uuid!);
      } else {
        controller = PreloadPageController(initialPage: widget.index);
        ref.read(videoControllerProvider.notifier).current(widget.index);
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      ref.read(artistControllerProvider);

      Future.delayed(Duration.zero, () {
        if (widget.uuid != null) {
          setItems(widget.uuid!);
        } else {
          controller = PreloadPageController(initialPage: widget.index);
          ref.read(videoControllerProvider.notifier).current(widget.index);
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var items = ref.watch(videoControllerProvider.select((v) => v.items));
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;

    return Scaffold(
      backgroundColor: Colors.black,
      body: controller == null
          ? CircularLoading()
          : PreloadPageView.builder(
              pageSnapping: true,
              preloadPagesCount: 1,
              controller: controller,
              itemCount: items.length,
              scrollDirection: Axis.vertical,
              physics: PageScrollPhysics(),
              onPageChanged: (value) {
                ref.read(videoControllerProvider.notifier).current(value);
              },
              itemBuilder: (context, index) {
                return BetterPlayerUi(
                  index: index,
                  cdnUrl: cdnUrl,
                  data: items[index],
                  key: Key(items[index].uuid),
                );
              },
            ),
    );
  }

  Future<void> setItems(String uuid) async {
    var index = await ref
        .read(recommendedVideoControllerProvider.notifier)
        .getById(uuid);

    index ??= 0;

    var state = await ref.read(recommendedVideoControllerProvider.future);

    ref
        .read(videoControllerProvider.notifier)
        .items(state.items, current: index);

    controller = PreloadPageController(initialPage: index);
  }
}
