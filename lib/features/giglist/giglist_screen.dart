import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/utils/date_format.dart';
import 'package:mobile_gigger_app/core/utils/get_share_url.dart';
import 'package:mobile_gigger_app/core/utils/num_format.dart';
import 'package:mobile_gigger_app/features/giglist/widgets/giglist_like_btn.dart';
import 'package:mobile_gigger_app/features/giglist/widgets/giglist_star_btn.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/status_widget.dart';
import 'package:mobile_gigger_app/models/availability_out.dart';
import 'package:mobile_gigger_app/models/post_form_extra.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/call_to_action_extension.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/giglist/giglist_player_screen.dart';
import 'package:mobile_gigger_app/features/giglist/providers/giglist_player_controller.dart';
import 'package:mobile_gigger_app/features/giglist/widgets/giglist_action_btn.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/get_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_info.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/call_to_action.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:mobile_gigger_app/widgets/video_delete_sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GiglistScreen extends ConsumerStatefulWidget {
  const GiglistScreen(this.data, this.cdnUrl, {super.key});

  final GigListOut data;
  final String? cdnUrl;

  @override
  ConsumerState<GiglistScreen> createState() => _GiglistScreenState();
}

class _GiglistScreenState extends ConsumerState<GiglistScreen> {
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(giglistPlayerControllerProvider);

    var artist = ref
        .watch(getProfileControllerProvider(widget.data.profileUuid))
        .whenData((v) => v)
        .valueOrNull;

    var profile =
        ref.watch(profileControllerProvider).whenData((v) => v).value!;

    if (artist == null) {
      return Scaffold(body: CircularLoading());
    }

    var isFromOwn = widget.data.profileUuid == profile.uuid;

    var wageRequested = numFormat(widget.data.wageRequested);

    return PopScope(
      canPop: !state.isMore,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          ref.read(giglistPlayerControllerProvider.notifier).isMore(false);
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: PageView.builder(
                onPageChanged: (value) => ref
                    .read(giglistPlayerControllerProvider.notifier)
                    .current(value),
                itemCount: widget.data.gigListMedia.values.length,
                itemBuilder: (context, index) {
                  return GiglistPlayerScreen(
                    key: Key('$index'),
                    isFromOwn: isFromOwn,
                    cdnUrl: widget.cdnUrl,
                    giglist: widget.data,
                    data: widget.data.gigListMedia.values.elementAt(index),
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 36,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => onBack(state.isMore),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          transformAlignment: Alignment.center,
                          transform: Matrix4.rotationZ(state.isMore ? 4.7 : 0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            shadows: [BoxShadow(blurRadius: 10)],
                          ),
                        ),
                      ),
                      GiglistActionBtn(
                        isFromOwn: isFromOwn,
                        onCreateSup: onCreateSup,
                        onEditContent: onEditContent,
                        onDeleteContent: showDeleteContentSheet,
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
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.black54,
                      Colors.transparent,
                    ],
                    stops: [0, .8, 1],
                  ),
                ),
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.data.gigListMedia.values.length > 1)
                      Center(
                        child: SizedBox(
                          height: 5,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.data.gigListMedia.values.length,
                            separatorBuilder: (_, __) => SizedBox(width: 4),
                            itemBuilder: (context, index) {
                              var isCurrent = state.current == index;

                              return Container(
                                width: isCurrent ? 10 : 5,
                                decoration: BoxDecoration(
                                  color: isCurrent ? colorWhite : colorTextGrey,
                                  borderRadius: isCurrent
                                      ? BorderRadius.circular(10)
                                      : null,
                                  shape: isCurrent
                                      ? BoxShape.rectangle
                                      : BoxShape.circle,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.isMore)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextViewWidget(
                                text: supDateFormat(widget.data.createdAt),
                                textSize: 12,
                              ),
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextViewWidget(
                                      text: widget.data.title,
                                      textSize: 26,
                                      height: 1,
                                    ),
                                    SizedBox(height: 10),
                                    if (widget.data.location.isNotEmpty)
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              color: colorWhite, size: 12),
                                          const SizedBox(width: 3),
                                          TextViewWidget(
                                            text: widget.data.location,
                                            textSize: 10,
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              GiglistStarBtn(
                                uuid: profile.uuid,
                                gigListUuid: widget.data.uuid,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              if (widget.data.isLookingFor)
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: TextViewWidget(
                                    text: 'WANTED!',
                                    color: colorRed,
                                    textSize: 21,
                                  ),
                                ),
                              TextViewWidget(
                                text: wageRequested == null
                                    ? 'ND'
                                    : '$wageRequested €',
                                textSize: 18,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SizeTransition(
                                  axisAlignment: 1,
                                  sizeFactor: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: !state.isMore
                                ? null
                                : Padding(
                                    key: ValueKey(widget.data.uuid),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ConstrainedBox(
                                          constraints:
                                              BoxConstraints(maxHeight: .2.sh),
                                          child: SingleChildScrollView(
                                            child: TextViewWidget(
                                              text: widget.data.description,
                                              textSize: 13,
                                            ),
                                          ),
                                        ),
                                        if (widget.data.hashtags.isNotEmpty)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: TextViewWidget(
                                              text: widget.data.hashtags
                                                  .map((e) => '#${e.name}')
                                                  .join(' '),
                                              color: colorRed,
                                              textSize: 13,
                                            ),
                                          ),
                                        SizedBox(height: 20),
                                        StatusWidget(
                                          isEditMode: false,
                                          availabilityStatus:
                                              artist.availabilityStatus,
                                          onTap: () => onStatusTap(
                                            artist.availabilityStatus,
                                            artist.availability,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 18.h,
                                            horizontal: 20,
                                          ),
                                          child: Row(
                                            children: [
                                              MenuItem(
                                                image: Assets.images.giShare,
                                                label: 'Share',
                                                onTap: onShareTap,
                                              ),
                                              SizedBox(width: 32.w),
                                              if (isFromOwn) ...[
                                                MenuItem(
                                                  image: Assets.images.giBoost,
                                                  label: 'Boost it!',
                                                  onTap: () {},
                                                ),
                                                SizedBox(width: 32.w),
                                                MenuItem(
                                                  image:
                                                      Assets.images.giInsights,
                                                  label: 'Insights',
                                                ),
                                              ] else ...[
                                                MenuItem(
                                                  image:
                                                      Assets.images.giMessage,
                                                  label: 'Message',
                                                  onTap: () => onMessageTap(
                                                    artist,
                                                    isFromOwn,
                                                  ),
                                                ),
                                                SizedBox(width: 32.w),
                                                GiglistLikeBtn(
                                                  uuid: profile.uuid,
                                                  gigListUuid: widget.data.uuid,
                                                ),
                                              ]
                                            ],
                                          ),
                                        ),
                                        if (!isFromOwn)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Row(
                                              children: [
                                                MenuItem(
                                                  icon: Icons.phone_outlined,
                                                  label: 'Tel',
                                                ),
                                                SizedBox(width: 32.w),
                                                MenuItem(
                                                  image: Assets
                                                      .images.whatsappIcon,
                                                  label: 'Whatsapp',
                                                ),
                                                SizedBox(width: 32.w),
                                                MenuItem(
                                                  image:
                                                      Assets.images.giSupport,
                                                  label: 'Support',
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                          ),
                          state.isMore &&
                                  widget.data.callToAction.name == 'None'
                              ? SizedBox()
                              : FilledButton(
                                  onPressed: () => onTapMore(
                                    state,
                                    widget.data.callToAction,
                                    artist,
                                    isFromOwn,
                                  ),
                                  style: FilledButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: Center(
                                    child: TextViewWidget(
                                      text: state.isMore
                                          ? widget.data.callToAction.index == 5
                                              ? 'Call Me!'
                                              : widget.data.callToAction.name
                                          : 'Show me more!',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      child: state.isMore
                          ? isFromOwn
                              ? SizedBox()
                              : VideoInfo(
                                  skills: artist.skills,
                                  actionIcon: Icons.chevron_right,
                                  username: artist.account.username,
                                  avatarMedia:
                                      '${widget.cdnUrl}/${artist.avatarMedia}',
                                  onTap: () async {
                                    // await controller.pause();

                                    if (!context.mounted) return;
                                    ProfileRoute(uuid: artist.uuid)
                                        .push(context);
                                  },
                                )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextViewWidget(
                                    text:
                                        'Published by ${artist.account.username}',
                                    textSize: 14,
                                  ),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.check_circle,
                                    color: colorRed,
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onBack(bool isMore) {
    if (isMore) {
      ref.read(giglistPlayerControllerProvider.notifier).isMore(false);
    } else {
      context.pop();
    }
  }

  void onEditContent() {
    var data = widget.data;

    ref.read(postFormControllerProvider.notifier)
      ..type(ContentType.giglist)
      ..latLngFrom(data.lat, data.long)
      ..setGiglistData(data);

    PostFormRoute(
      uuid: data.uuid,
      title: data.title,
      place: data.location,
      caption: data.description,
      $extra: PostFormExtra(hashtags: data.hashtags),
    ).go(context);
  }

  Future<void> showDeleteContentSheet() async {
    // await controller?.pause();

    // if (!mounted) return;

    SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(
        onDelete: onDelete,
        confirmText: 'Yes delete my giglist',
        title: 'YOU ARE DELETING THIS GIGLIST, ARE YOU SURE?',
      ),
    );
  }

  Future<void> onDelete() async {
    try {
      overlayEntry = OverlayEntry(builder: (_) => OverlayLoading());

      Overlay.of(context).insert(overlayEntry!);
      setState(() {});

      await ref
          .read(postFormControllerProvider.notifier)
          .deleteGiglist(widget.data.uuid);

      if (!mounted) return;

      overlayEntry?.remove();

      context.pop();

      MainRoute().go(context);
    } catch (e) {
      overlayEntry?.remove();

      Toast.error(e.toString());
    }
  }

  Future<void> onTapMore(
    GiglistPlayerState state,
    CallToAction callToAction,
    ProfileOut artist,
    bool isFromOwn,
  ) async {
    if (!state.isMore) {
      ref.read(giglistPlayerControllerProvider.notifier).isMore(true);
      return;
    }

    if (callToAction.index == 1) {
      return onMessageTap(artist, isFromOwn);
    }

    if (callToAction.index == 3) {
      return AvailabilityRoute(
        status: artist.availabilityStatus,
        $extra: artist.availability,
        viewOnly: true,
      ).push(context);
    }

    if (callToAction.index == 4) {
      return ProfileRoute(uuid: artist.uuid).push(context);
    }

    if (callToAction.index == 6 || callToAction.index == 7) {
      var canLaunch = await canLaunchUrlString(callToAction.value);
      if (canLaunch) launchUrlString(callToAction.value);
      return;
    }

    Toast.error('Currently not supported');
  }

  void onCreateSup() {
    ref.read(postFormControllerProvider.notifier)
      ..type(ContentType.sup)
      ..createdFrom(SupCreatedFromEnum.gigList);

    PostFormRoute().push(context);
  }

  void onShareTap() {
    Share.share(
      'Check out this giglist ${getGiglistShareUrl(widget.data.uuid)}',
    );
  }

  void onMessageTap(ProfileOut artist, bool isFromOwn) {
    if (isFromOwn) {
      NotiRoute(index: 1).push(context);
    } else {
      ChatRoute(
        type: 'giglist',
        uuid: artist.uuid,
        dataUuid: widget.data.uuid,
        giglistTitle: widget.data.title,
      ).push(context);
    }
  }

  void onStatusTap(
    bool availabilityStatus,
    List<AvailabilityOut> availability,
  ) {
    AvailabilityRoute(
      status: availabilityStatus,
      $extra: availability,
    ).push(context);
  }
}
