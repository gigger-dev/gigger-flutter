// import 'package:better_player_plus/better_player_plus.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mobile_gigger_app/core/consts/color.dart';
// import 'package:mobile_gigger_app/features/sup/providers/sup_player_controller.dart';
// import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';
// import 'package:mobile_gigger_app/gen/assets.gen.dart';
// import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
// import 'package:mobile_gigger_app/models/sup_out.dart';
// import 'package:mobile_gigger_app/widgets/circular_loading.dart';
// import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

// class SupPlayer extends ConsumerStatefulWidget {
//   const SupPlayer(this.data, this.cdnUrl, this.profile, {super.key});

//   final SupOut data;
//   final String? cdnUrl;
//   final ProfileFewerDetailsOut profile;

//   @override
//   ConsumerState<SupPlayer> createState() => _SupPlayerState();
// }

// class _SupPlayerState extends ConsumerState<SupPlayer> {
//   late BetterPlayerController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = BetterPlayerController(
//       BetterPlayerConfiguration(
//         looping: true,
//         controlsConfiguration: BetterPlayerControlsConfiguration(
//           showControls: false,
//           showControlsOnInitialize: false,
//         ),
//       ),
//       betterPlayerDataSource: BetterPlayerDataSource.network(
//         '${widget.cdnUrl}/${widget.data.videoUrl}',
//         cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true),
//       ),
//     );

//     controller.addEventsListener(eventListener);

//     // controller = BetterPlayerController.networkUrl(
//     //   Uri.parse('${widget.cdnUrl}/${widget.data.videoUrl}'),
//     // )..initialize().whenComplete(() {
//     //     controller.play();
//     //     setState(() {});
//     //   });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         GestureDetector(
//           onPanDown:
//               controller.isVideoInitialized() == false ? null : onPanDown,
//           onPanEnd: controller.isVideoInitialized() == false ? null : onPanEnd,
//           child: Stack(
//             alignment: Alignment.center,
//             fit: StackFit.expand,
//             children: [
//               Container(
//                 color: colorBlack1A,
//                 child: controller.isVideoInitialized() == false
//                     ? CircularLoading()
//                     : BetterPlayer(controller: controller),
//               ),
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Color.fromRGBO(0, 0, 0, 0.93),
//                         colorTransparent,
//                         colorTransparent,
//                         Color.fromRGBO(0, 0, 0, 0.93),
//                       ],
//                       stops: [0, .2, .8, 1],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   child: Column(
//                     children: [
//                       TextViewWidget(
//                         text: widget.data.caption,
//                         textSize: 20,
//                       ),
//                       SizedBox(height: 24),
//                       Row(
//                         children: [
//                           MenuItem(
//                             image: Assets.images.giShare,
//                             label: 'Share',
//                           ),
//                           SizedBox(width: 32.w),
//                           MenuItem(
//                             image: Assets.images.giMessage,
//                             label: 'Message',
//                           ),
//                           SizedBox(width: 32.w),
//                           MenuItem(
//                             image: Assets.images.like,
//                             label: '0',
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Row(
//                   children: [
//                     Container(
//                       height: 46,
//                       width: 46,
//                       decoration: BoxDecoration(
//                         color: colorGrey,
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             '${widget.cdnUrl}/${widget.profile.avatarMedia}',
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child:
//                           TextViewWidget(text: widget.profile.account.username),
//                     ),
//                     SizedBox(width: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: colorRed),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//                       child: TextViewWidget(
//                         text: 'S\'Up!',
//                         color: colorRed,
//                         textSize: 12,
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> onPanDown(_) async {
//     ref.read(supPlayerControllerProvider.notifier).isPause(true);
//     await controller.pause();
//   }

//   Future<void> onPanEnd(_) async {
//     ref.read(supPlayerControllerProvider.notifier).isPause(false);
//     await controller.play();
//   }

//   void eventListener(BetterPlayerEvent event) {
//     if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
//       if (controller.videoPlayerController != null) {
//         if (!(controller.isPlaying() ?? false)) {
//           controller.play();
//         }

//         controller.setOverriddenAspectRatio(
//           controller.videoPlayerController!.value.aspectRatio,
//         );

//         setState(() {});
//       }
//     }
//   }
// }
