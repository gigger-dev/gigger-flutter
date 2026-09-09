import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mobile_gigger_app/core/utils/get_share_url.dart';
import 'package:mobile_gigger_app/features/home/providers/post_metadata_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/get_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/video_player/providers/video_controller.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/custom_rectangular_slider_thumb.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_action_btn.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_info.dart';
import 'package:mobile_gigger_app/models/post_form_extra.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/loading.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:mobile_gigger_app/widgets/video_delete_sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:volume_controller/volume_controller.dart';

class BetterPlayerUi extends ConsumerStatefulWidget {
  const BetterPlayerUi({
    super.key,
    required this.index,
    this.cdnUrl,
    required this.data,
  });

  final int index;
  final String? cdnUrl;
  final PostOut data;

  @override
  ConsumerState<BetterPlayerUi> createState() => _BetterPlayerUiState();
}

class _BetterPlayerUiState extends ConsumerState<BetterPlayerUi> {
  late BetterPlayerController controller;

  OverlayEntry? overlayEntry;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    debugPrint('playing: ${'${widget.cdnUrl}/${widget.data.videoUrl}'}');
    setController();

    Future.delayed(Duration.zero, () {
      ref.read(videoControllerProvider.notifier).showPlayPauseIcon(false);

      viewPost();
      fadeMenu();

      VolumeController.instance.addListener(
        (volume) => ref.read(videoControllerProvider.notifier).volume(volume),
        fetchInitialVolume: true,
      );
    });

    controller.addEventsListener(eventListener);
  }

  void viewPost() {
    var viewerUuid = ref.read(profileControllerProvider).value!.uuid;

    var controller = ref.read(
      postMetadataControllerProvider(
        postUuid: widget.data.uuid,
        viewerUuid: viewerUuid,
      ).notifier,
    );
    controller.view();
  }

  void fadeMenu() {
    ref.read(videoControllerProvider.notifier).showMenu(true);

    resetTimer();
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;

      setState(() {});
    }
  }

  void resetTimer() {
    cancelTimer();

    _timer = Timer.periodic(
      const Duration(seconds: 6),
      (timer) {
        if (!mounted) return;
        var showingAction = ref.read(videoControllerProvider).showingAction;
        if (!showingAction) {
          ref.read(videoControllerProvider.notifier).showMenu(false);
        }

        timer.cancel();
      },
    );

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    VolumeController.instance.removeListener();

    controller.removeEventsListener(eventListener);
    controller.pause();
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BetterPlayerUi oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      setController();
      fadeMenu();
    }
  }

  void setController() {
    controller = BetterPlayerController(
      BetterPlayerConfiguration(
        looping: true,
        placeholder: CircularLoading(),
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
          showControlsOnInitialize: false,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(
        '${widget.cdnUrl}/${widget.data.videoUrl}',
        cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true),
        bufferingConfiguration: BetterPlayerBufferingConfiguration(
          // minBufferMs: 15000, // Reduce min buffer size
          // maxBufferMs: 50000, // Reduce max buffer size
          // bufferForPlaybackMs: 2500,
          // bufferForPlaybackAfterRebufferMs: 5000,
          minBufferMs: 5000,
          maxBufferMs: 10000,
          bufferForPlaybackMs: 2000,
          bufferForPlaybackAfterRebufferMs: 3000,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(videoControllerProvider);

    var profile =
        ref.watch(profileControllerProvider).whenData((v) => v).value!;

    ProfileOut? artist;

    if (widget.data.profileUuid == profile.uuid) {
      artist = profile;
    } else {
      artist = ref
          .watch(getProfileControllerProvider(widget.data.profileUuid))
          .valueOrNull;
    }

    ref.listen(
      videoControllerProvider,
      (previous, next) {
        if (controller.videoPlayerController == null) return;

        if (next.current != widget.index) {
          controller.pause();
        } else if (!next.isPause) {
          controller.play();
          controller.setOverriddenAspectRatio(
            controller.videoPlayerController!.value.aspectRatio,
          );
        }
      },
    );

    var isCurrent = state.current == widget.index;

    // if (controller.videoPlayerController?.value == null) {
    //   return Center(child: CircularProgressIndicator());
    // }

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => onTap(state.showMenu),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: BetterPlayer(controller: controller),
                ),
                Positioned.fill(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: !state.showMenu
                        ? SizedBox()
                        : Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(0, 0, 0, .9),
                                  colorTransparent,
                                  colorTransparent,
                                  Color.fromRGBO(0, 0, 0, .9),
                                ],
                                stops: [.08, .14, .84, .9],
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        IgnorePointer(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: !state.showMenu
                ? const SizedBox(key: ValueKey('hide_menu'))
                : !state.showPlayPauseIcon
                    ? const SizedBox(key: ValueKey('play_widget'))
                    : Center(
                        key: const ValueKey('pause_icon'),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(.4),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Icon(
                            state.isPause ? Icons.pause : Icons.play_arrow,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: !state.showHeartIcon
              ? const SizedBox(
                  key: ValueKey('hide_heart'),
                )
              : const Icon(
                  key: ValueKey('show_heart'),
                  CupertinoIcons.heart_fill,
                  color: Colors.red,
                  size: 80,
                ),
        ),
        Positioned(
          left: 0,
          top: 36,
          right: 0,
          child: AbsorbPointer(
            child: SizedBox(height: 100, width: 1.sw),
          ),
        ),
        Positioned(
          left: 0,
          top: 36,
          right: 0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: !state.showMenu || !isCurrent
                ? const SizedBox()
                : Padding(
                    key: const ValueKey('show_top'),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => context.pop(true),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            shadows: [BoxShadow(blurRadius: 10)],
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
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
                              activeColor: Colors.red,
                              inactiveColor: Colors.grey,
                              onChanged: onDurationChanged,
                              max: controller.videoPlayerController?.value
                                      .duration?.inSeconds
                                      .toDouble() ??
                                  0,
                              value: controller.videoPlayerController?.value
                                      .position.inSeconds
                                      .toDouble() ??
                                  0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        InkWell(
                          onTap: onVolumeTap,
                          child: Icon(
                            state.isMute
                                ? Icons.volume_off
                                : state.volume < .5
                                    ? Icons.volume_down
                                    : Icons.volume_up,
                            size: 20,
                            color: Colors.white,
                            shadows: [BoxShadow(blurRadius: 10)],
                          ),
                        ),
                        const SizedBox(width: 12),
                        VideoActionBtn(
                          onShareTap: onShareTap,
                          onCreateSup: onCreateSup,
                          onSendDmTap: onSendDmTap,
                          onEditContent: onEditContent,
                          onCopyLinkTap: onCopyLinkTap,
                          onDeleteContent: showDeleteContentSheet,
                          isFromOwn: widget.data.profileUuid == profile.uuid,
                        )
                      ],
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: !state.showMenu ||
                    state.showInfoSheet ||
                    artist == null ||
                    !isCurrent
                ? const SizedBox()
                : VideoInfo(
                    skills: artist.skills,
                    key: ValueKey('show_bottom'),
                    username: artist.account.username,
                    avatarMedia: '${widget.cdnUrl}/${artist.avatarMedia}',
                    onTap: () => onVideoInfoTap(artist, profile),
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> onDurationChanged(double value) async {
    await controller.pause();
    await controller.seekTo(Duration(seconds: value.toInt()));
    await controller.play();
  }

  void onVolumeTap() {
    ref.read(videoControllerProvider.notifier).toggleMute();
  }

  Future<void> onCreateSup() async {
    await pauseVideo();

    ref.read(postFormControllerProvider.notifier)
      ..type(ContentType.sup)
      ..createdFrom(SupCreatedFromEnum.post);

    if (mounted) PostFormRoute().push(context);
  }

  Future<void> onEditContent() async {
    await controller.pause();

    var data = widget.data;

    ref.read(postFormControllerProvider.notifier)
      ..type(ContentType.post)
      ..latLngFrom(data.lat, data.long)
      ..videoUrl(
        videoUrl: data.videoUrl,
        thumbnailImageUrl: data.thumbnailUrl,
      );

    if (!mounted) return;

    PostFormRoute(
      uuid: data.uuid,
      caption: data.caption,
      title: data.postTitle,
      place: data.location,
      musicTitle: data.musicTitle,
      $extra: PostFormExtra(hashtags: data.hashtags),
    ).go(context);
  }

  void showDeleteContentSheet() {
    SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(onDelete: onDelete),
    );
  }

  Future<void> onVideoInfoTap(ProfileOut? artist, ProfileOut profile) async {
    ref.read(videoControllerProvider.notifier).showInfoSheet(true);

    await onInfoTap(
      artist!,
      isFromOwn: widget.data.profileUuid == profile.uuid,
    );

    ref.read(videoControllerProvider.notifier).showInfoSheet(false);
  }

  Future<void> onInfoTap(ProfileOut profile, {required bool isFromOwn}) async {
    // if (controller.value.isPlaying) await controller.pause();

    if (!mounted) return;

    var profileTap = await showModalBottomSheet<bool>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Colors.black.withOpacity(.7),
      builder: (_) => VideoDetailSheet(
        profile: profile,
        data: widget.data,
        isFromOwn: isFromOwn,
        cdnUrl: widget.cdnUrl ?? '',
      ),
    );

    if (profileTap == true) {
      // await pauseVideo();

      if (!mounted) return;
      ProfileRoute(uuid: profile.uuid).go(context);
    }
  }

  Future<void> onDelete() async {
    try {
      overlayEntry = OverlayEntry(builder: (_) => OverlayLoading());

      Overlay.of(context).insert(overlayEntry!);
      setState(() {});

      await ref
          .read(postFormControllerProvider.notifier)
          .deletePost(widget.data.uuid, widget.data.profileUuid);

      if (!mounted) return;

      overlayEntry?.remove();

      context.pop();

      ref.read(recommendedVideoControllerProvider.notifier).refresh();

      MainRoute().go(context);
    } catch (e) {
      overlayEntry?.remove();

      Toast.error(e.toString());
    }
  }

  Future<void> pauseVideo() async {
    // cancelTimer();
    await controller.pause();

    ref.read(videoControllerProvider.notifier).showPlayPauseIcon(true);
    ref.read(videoControllerProvider.notifier).isPause(true);

    await controller.pause();
  }

  void eventListener(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (controller.videoPlayerController != null) {
        if (ref.read(videoControllerProvider).current != widget.index) return;

        if (!(controller.isPlaying() ?? false)) {
          controller.play();
        }

        controller.setOverriddenAspectRatio(
          controller.videoPlayerController!.value.aspectRatio,
        );
      }
    }

    setState(() {});
  }

  Future<void> onTap(bool showMenu) async {
    if (controller.isBuffering() ?? true) return;

    if (!showMenu) {
      fadeMenu();
      return;
    }

    resetTimer();

    if (controller.isPlaying() ?? false) {
      await controller.pause();

      ref.read(videoControllerProvider.notifier).showPlayPauseIcon(true);
      ref.read(videoControllerProvider.notifier).isPause(true);

      await controller.pause();
    } else {
      await controller.play();
      ref.read(videoControllerProvider.notifier).showPlayPauseIcon(true);
      ref.read(videoControllerProvider.notifier).isPause(false);
    }

    await Future.delayed(const Duration(milliseconds: 600));

    ref.read(videoControllerProvider.notifier).showPlayPauseIcon(false);
  }

  void onShareTap() {
    Share.share('Check out this video ${getVideoShareUrl(widget.data.uuid)}');
  }

  void onSendDmTap() {
    ChatRoute(uuid: widget.data.profileUuid).push(context);
  }

  void onCopyLinkTap() {
    Clipboard.setData(ClipboardData(text: getVideoShareUrl(widget.data.uuid)));
  }
}
