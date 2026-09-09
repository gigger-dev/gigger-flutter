import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/home/providers/selector_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/sup_controller.dart';
import 'package:mobile_gigger_app/features/sup/providers/sup_player_controller.dart';
import 'package:mobile_gigger_app/features/sup/sup_screen.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';

class SupAllScreen extends ConsumerStatefulWidget {
  const SupAllScreen({super.key, this.index, this.uuid});

  final int? index;
  final String? uuid;

  @override
  ConsumerState<SupAllScreen> createState() => _SupAllScreenState();
}

class _SupAllScreenState extends ConsumerState<SupAllScreen> {
  PageController? controller;

  @override
  void initState() {
    super.initState();
    if (widget.uuid == null) {
      controller = PageController(initialPage: widget.index ?? 0);
    } else {
      Future.delayed(Duration.zero, () => setItem(widget.uuid!));
    }
  }

  Future<void> setItem(String uuid) async {
    var r = await ref.read(getSupByIdProvider(uuid).future);
    ref.read(selectorControllerProvider.notifier).updateEnum(r.createFrom);
    var index = await ref
        .read(supControllerProvider(r.createFrom).notifier)
        .getIndex(r.profileUuid);

    var _index = await ref
        .read(
            supProfileControllerProvider(r.profileUuid, r.createFrom).notifier)
        .getIndex(r.uuid);

    ref.read(supPlayerControllerProvider.notifier).storyIndex(_index);

    controller = PageController(initialPage: index);
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var createFrom = ref.watch(selectorControllerProvider);

    var items =
        ref.watch(supControllerProvider(createFrom)).valueOrNull?.items ?? [];

    if (controller == null) {
      return Scaffold(
        body: CircularLoading(),
        backgroundColor: colorBlack,
      );
    }

    return PageView.builder(
      controller: controller,
      itemCount: items.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        // return SupScreen(
        //   data: items[index],
        //   onComplete: () {
        //     if (index == items.length - 1) {
        //       try {
        //         if (context.canPop()) return context.pop();
        //       } catch (_) {}
        //     }

        //     ref.read(supPlayerControllerProvider.notifier).storyIndex(0);

        //     controller?.nextPage(
        //       duration: Duration(milliseconds: 400),
        //       curve: Curves.ease,
        //     );
        //   },
        // );
        return SupScreen(
          data: items[index],
          onComplete: () {
            if (index == items.length - 1) {
              try {
                if (context.canPop()) return context.pop();
              } catch (_) {}
            }

            ref.read(supPlayerControllerProvider.notifier).storyIndex(0);

            controller?.nextPage(
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          },
        );
      },
    );
  }
}

// class SupScreen extends ConsumerStatefulWidget {
//   const SupScreen({super.key, required this.data, required this.onComplete});

//   final ProfileFewerDetailsOut data;
//   final VoidCallback onComplete;

//   @override
//   ConsumerState<SupScreen> createState() => _SupScreenState();
// }

// class _SupScreenState extends ConsumerState<SupScreen> {
//   final controller = PageController();

//   @override
//   Widget build(BuildContext context) {
//     var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;

//     var createFrom = ref.watch(selectorControllerProvider);
//     var state =
//         ref.watch(supProfileControllerProvider(widget.data.uuid, createFrom));

//     var storyIndex =
//         ref.watch(supPlayerControllerProvider.select((v) => v.storyIndex));

//     return Scaffold(
//       backgroundColor: colorBlack,
//       body: state.whenOrNull(
//         data: (data) => PageView.builder(
//           itemCount: data.length,
//           controller: controller,
//           itemBuilder: (context, index) {
//             return SupItem(
//               cdnUrl: cdnUrl!,
//               data: data[index],
//               isCurrent: storyIndex == index,
//               onFinished: () {
//                 if (index == data.length - 1) {
//                   widget.onComplete();
//                 } else {
//                   controller.nextPage(
//                     duration: Duration(milliseconds: 400),
//                     curve: Curves.ease,
//                   );
//                 }
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class SupItem extends StatefulWidget {
//   const SupItem({
//     super.key,
//     required this.cdnUrl,
//     required this.data,
//     required this.onFinished,
//     required this.isCurrent,
//   });

//   final SupOut data;
//   final String cdnUrl;
//   final bool isCurrent;
//   final VoidCallback onFinished;

//   @override
//   State<SupItem> createState() => _SupItemState();
// }

// class _SupItemState extends State<SupItem> {
//   late BetterPlayerController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = BetterPlayerController(
//       BetterPlayerConfiguration(
//         autoPlay: false,
//         placeholder: CircularLoading(),
//         controlsConfiguration: BetterPlayerControlsConfiguration(
//           showControls: false,
//           showControlsOnInitialize: false,
//         ),
//       ),
//       betterPlayerDataSource: BetterPlayerDataSource.network(
//         '${widget.cdnUrl}/${widget.data.videoUrl}',
//         cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true),
//         bufferingConfiguration: BetterPlayerBufferingConfiguration(
//           minBufferMs: 15000, // Reduce min buffer size
//           maxBufferMs: 50000, // Reduce max buffer size
//           bufferForPlaybackMs: 2500,
//           bufferForPlaybackAfterRebufferMs: 5000,
//         ),
//       ),
//     );

//     if (widget.isCurrent) {
//       controller.play();
//     }

//     controller.addEventsListener(eventListener);
//   }

//   @override
//   void dispose() {
//     controller.removeEventsListener(eventListener);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BetterPlayer(controller: controller);
//   }

//   void eventListener(BetterPlayerEvent event) {
//     if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
//       if (controller.videoPlayerController != null) {
//         controller.setOverriddenAspectRatio(
//           controller.videoPlayerController!.value.aspectRatio,
//         );
//         setState(() {});
//       }
//     }

//     if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
//       widget.onFinished();
//     }
//   }
// }
