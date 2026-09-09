import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_story_presenter/flutter_story_presenter.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/date_format.dart';
import 'package:mobile_gigger_app/core/utils/get_share_url.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/home/providers/new_sup_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/selector_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/sup_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/get_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/features/sup/providers/sup_metadata_controller.dart';
import 'package:mobile_gigger_app/features/sup/providers/sup_player_controller.dart';
import 'package:mobile_gigger_app/features/sup/widgets/sup_like_btn.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/models/skill_out.dart';
import 'package:mobile_gigger_app/models/sup_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/loading.dart';
import 'package:mobile_gigger_app/widgets/popup_btn.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:mobile_gigger_app/widgets/video_delete_sheet.dart';
import 'package:popover/popover.dart';
import 'package:share_plus/share_plus.dart';

class SupScreen extends ConsumerStatefulWidget {
  const SupScreen({
    super.key,
    required this.data,
    required this.onComplete,
  });

  final ProfileFewerDetailsOut data;
  final VoidCallback onComplete;

  @override
  ConsumerState<SupScreen> createState() => _SupScreenState();
}

class _SupScreenState extends ConsumerState<SupScreen> {
  final controller = FlutterStoryController();

  OverlayEntry? overlayEntry;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;

    var profile = ref.watch(profileControllerProvider).value!;

    var createFrom = ref.watch(selectorControllerProvider);
    var state =
        ref.watch(supProfileControllerProvider(widget.data.uuid, createFrom));

    var artist = ref
        .watch(getProfileControllerProvider(widget.data.uuid))
        .whenData((v) => v)
        .valueOrNull;

    var index =
        ref.watch(supPlayerControllerProvider.select((v) => v.storyIndex));

    return Scaffold(
      backgroundColor: colorBlack,
      body: state.whenOrNull(
        loading: () => CircularLoading(),
        data: (data) => FlutterStoryPresenter(
          restartOnCompleted: false,
          flutterStoryController: controller,
          storyViewIndicatorConfig: StoryViewIndicatorConfig(
            activeColor: colorRed,
          ),
          onSlideDown: (p0) => context.pop(),
          onCompleted: () async => onCompleted(data, profile, index),
          headerWidget: widget.data.uuid != profile.uuid
              ? null
              : Container(
                  height: 80,
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 24),
                  padding: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 1),
                        Color.fromRGBO(0, 0, 0, 0.8),
                        Color.fromRGBO(0, 0, 0, 0.7),
                        colorTransparent,
                      ],
                      stops: [.35, .5, .6, 1],
                    ),
                  ),
                  child: PopupBtn(
                    direction: PopoverDirection.bottom,
                    items: [
                      PopupItem(
                        title: 'Delete',
                        onTap: () => onDeleteContent(data[index]),
                      )
                    ],
                  ),
                ),
          footerWidget: AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            child: SupFooter(
              cdnUrl: cdnUrl,
              key: ValueKey(index),
              profile: widget.data,
              skills: artist?.skills ?? [],
              data: data.elementAtOrNull(index),
              isVisitor: widget.data.uuid != profile.uuid,
            ),
          ),
          onStoryChanged: (v) => Future.delayed(Duration.zero, () {
            ref.read(supPlayerControllerProvider.notifier).storyIndex(v);

            if (v == 0) return;

            ref
                .read(newSupControllerProvider(widget.data.uuid).notifier)
                .view(data[v - 1].uuid);
          }),
          items: [
            for (var e in data)
              StoryItem(
                url: e.videoUrl.isEmpty
                    ? '$cdnUrl/${e.thumbnailUrl}'
                    : '$cdnUrl/${e.videoUrl}',
                storyItemType: e.videoUrl.isEmpty
                    ? StoryItemType.image
                    : StoryItemType.video,
                storyItemSource: StoryItemSource.network,
                imageConfig: StoryViewImageConfig(),
                videoConfig: StoryViewVideoConfig(
                  cacheVideo: true,
                  useVideoAspectRatio: false,
                  loadingWidget: CircularLoading(),
                  configuration: BetterPlayerConfiguration(
                    autoPlay: true,
                    autoDispose: false,
                    placeholder: CircularLoading(),
                    controlsConfiguration: BetterPlayerControlsConfiguration(
                      showControls: false,
                      showControlsOnInitialize: false,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onDeleteContent(SupOut data) {
    SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(
        onDelete: () => onDelete(data),
        confirmText: 'Yes delete my sup',
        title: 'YOU ARE DELETING THIS SUP, ARE YOU SURE?',
      ),
    );
  }

  Future<void> onDelete(SupOut data) async {
    try {
      overlayEntry = OverlayEntry(builder: (_) => OverlayLoading());

      Overlay.of(context).insert(overlayEntry!);
      setState(() {});

      await ref.read(postFormControllerProvider.notifier).deleteSUp(data.uuid);

      if (!mounted) return;

      overlayEntry?.remove();

      context.pop();

      MainRoute().go(context);
    } catch (e) {
      overlayEntry?.remove();

      Toast.error(e.toString());
    }
  }

  Future<void> onCompleted(
    List<SupOut> data,
    ProfileOut profile,
    int index,
  ) async {
    var provider = supMetadataControllerProvider(
      supUuid: data[index].uuid,
      viewerUuid: profile.uuid,
    );

    var state = await ref.read(provider.future);

    if (!state.hasAlreadyViewed) {
      await ref.read(provider.notifier).view();
      await ref
          .read(newSupControllerProvider(widget.data.uuid).notifier)
          .view(data.last.uuid);
    }

    widget.onComplete();
  }
}

class SupFooter extends ConsumerWidget {
  const SupFooter({
    super.key,
    required this.data,
    this.cdnUrl,
    required this.profile,
    required this.skills,
    required this.isVisitor,
  });

  final SupOut? data;
  final String? cdnUrl;
  final bool isVisitor;
  final List<SkillOut> skills;
  final ProfileFewerDetailsOut profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (data == null) return SizedBox();

    var newSups = ref.watch(newSupControllerProvider(profile.uuid));

    var isNew = newSups[profile.uuid]?[data!.uuid] ?? false;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromRGBO(0, 0, 0, 0.9),
            Color.fromRGBO(0, 0, 0, 0.8),
            Color.fromRGBO(0, 0, 0, 0.6),
            colorTransparent,
          ],
          stops: [.2, .6, .8, 1],
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isVisitor)
            TextViewWidget(
              text: 'PUBLISHED: ${supDateFormat(data!.createdAt)}',
              textSize: 12,
            ),
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                TextViewWidget(
                  text: data!.caption,
                  textSize: 21,
                  textAlign: TextAlign.center,
                  height: 1.1,
                ),
                if (data!.taggedProfilesDetails.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Wrap(
                      spacing: 4,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: data!.taggedProfilesDetails.map((e) {
                        return GestureDetector(
                          onTap: () => ProfileRoute(uuid: e.uuid).push(context),
                          child: TextViewWidget(
                            text: '@${e.account.username}',
                            color: colorTextRed,
                            textSize: 13,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                SizedBox(height: 24),
                Row(
                  children: [
                    MenuItem(
                      image: Assets.images.giShare,
                      label: 'Share',
                      onTap: onShare,
                    ),
                    SizedBox(width: 32.w),
                    isVisitor
                        ? MenuItem(
                            label: 'Message',
                            image: Assets.images.giMessage,
                            onTap: () => ChatRoute(uuid: data!.profileUuid)
                                .push(context),
                          )
                        : MenuItem(
                            image: Assets.images.giInsights,
                            label: 'Insights',
                          ),
                    SizedBox(width: 32.w),
                    SupLikeBtn(data!.uuid),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ProfileRoute(uuid: profile.uuid).push(context);
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                          color: colorGrey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              '$cdnUrl/${profile.avatarMedia}',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextViewWidget(text: profile.account.username),
                            const SizedBox(height: 1),
                            TextViewWidget(
                              text: skills.map((e) => e.name).join(', '),
                              textSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              if (isNew)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: TextViewWidget(
                    text: 'New S\'UP!',
                    color: colorRed,
                    textSize: 12,
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }

  void onShare() {
    Share.share('Check out this sup ${getSupShareUrl(data!.uuid)}');
  }
}
