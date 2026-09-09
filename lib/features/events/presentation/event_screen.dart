import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/core/helpers/event_helper.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/get_share_url.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/event_form/providers/event_form_controller.dart';
import 'package:mobile_gigger_app/features/event_form/widgets/select_reminder_sheet.dart';
import 'package:mobile_gigger_app/features/events/presentation/providers/event_player_controller.dart';
import 'package:mobile_gigger_app/features/events/presentation/widgets/event_action_btn.dart';
import 'package:mobile_gigger_app/features/events/presentation/widgets/event_detail_sheet.dart';
import 'package:mobile_gigger_app/features/events/presentation/widgets/event_player_widget.dart';
import 'package:mobile_gigger_app/features/home/providers/event_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/event_metadata_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/get_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:mobile_gigger_app/widgets/video_delete_sheet.dart';
import 'package:share_plus/share_plus.dart';

class EventScreen extends ConsumerStatefulWidget {
  const EventScreen({
    super.key,
    required this.data,
  });

  final EventOut data;

  @override
  ConsumerState<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends ConsumerState<EventScreen> {
  late EventOut data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    Future.delayed(Duration.zero, viewEvent);
  }

  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).value!.cdnUrl;
    var state = ref.watch(eventPlayerControllerProvider);

    var profile = ref.watch(profileControllerProvider).value!;

    var isFromOwn = data.profileUuid == profile.uuid;

    var artist = ref
        .watch(getProfileControllerProvider(data.profileUuid))
        .whenData((v) => v)
        .valueOrNull;

    return Scaffold(
      backgroundColor: colorBlack,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                EventPlayerWidget(
                  cdnUrl: cdnUrl,
                  thumbnailUrl: data.thumbnailUrl,
                  videoOrImageUrl: data.videoOrImageUrl,
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
                              transform:
                                  Matrix4.rotationZ(state.isMore ? 4.7 : 0),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                shadows: [BoxShadow(blurRadius: 10)],
                              ),
                            ),
                          ),
                          EventActionBtn(
                            isFromOwn: isFromOwn,
                            onShareTap: onShareTap,
                            onCreateSup: onCreateSup,
                            onEditContent: onEditContent,
                            onAddReminder: onAddReminder,
                            onDeleteContent: showDeleteContentSheet,
                            onAcceptTap: () => onAcceptTap(profile.uuid),
                            onRejectTap: () => onRejectTap(profile.uuid),
                            isLineUp: isFromOwn
                                ? false
                                : data.lineUpNPerformersOut.any((e) {
                                    return e.profileUuid == profile.uuid &&
                                        !e.isAccepted;
                                  }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 84,
                  right: 26,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorBtnOrangeRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextViewWidget(
                          text: '${data.startTime.toLocal().day}',
                          color: colorWhite,
                          textSize: 16.sp,
                          height: 1,
                        ),
                        TextViewWidget(
                          text:
                              DateFormat.MMM().format(data.startTime.toLocal()),
                          color: colorWhite,
                          textSize: 10.sp,
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Opacity(
            opacity: state.isMore ? 0 : 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  TextViewWidget(
                    text: data.name,
                    textSize: 22.sp,
                  ),
                  SizedBox(height: 10.sp),
                  DefaultTextStyle(
                    style: TextStyle(fontSize: 13.sp),
                    child: IconTheme(
                      data: IconThemeData(size: 13.sp),
                      child: Row(
                        mainAxisAlignment: data.genre.isEmpty
                            ? MainAxisAlignment.spaceAround
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on, color: colorWhite),
                              const SizedBox(width: 3),
                              TextViewWidget(text: data.location),
                            ],
                          ),
                          if (data.genre.isNotEmpty)
                            TextViewWidget(text: '@ ${data.genre}'),
                          Row(
                            children: [
                              Icon(CupertinoIcons.clock, color: colorWhite),
                              const SizedBox(width: 3),
                              TextViewWidget(
                                text:
                                    'Start ${DateFormat('hh.mma').format(data.startTime.toLocal()).toLowerCase()}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  FilledButton(
                    onPressed: onMoreTap,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Center(child: TextViewWidget(text: 'Show me more!')),
                  ),
                  if (!isFromOwn)
                    Padding(
                      padding: EdgeInsets.only(top: 20.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextViewWidget(
                            text: 'Organized by ${artist?.account.username}',
                            textSize: 14.sp,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onBack(bool isMore) {
    context.pop();
  }

  Future<void> onMoreTap() async {
    ref.read(eventPlayerControllerProvider.notifier).isMore(true);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorBlack.withOpacity(.4),
      builder: (context) => EventDetailSheet(data),
    );

    ref.read(eventPlayerControllerProvider.notifier).isMore(false);
  }

  void onEditContent() {
    EventFormRoute($extra: data).go(context);
  }

  void showDeleteContentSheet() {
    SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(
        onDelete: onDelete,
        confirmText: 'Yes delete my event',
        title: 'YOU ARE DELETING THIS EVENT, ARE YOU SURE?',
      ),
    );
  }

  Future<void> onDelete() async {
    try {
      DialogHelper.showOverlay(context);

      await ref.read(eventFormControllerProvider.notifier).delete(data.uuid);
      ref.read(eventControllerProvider.notifier).refresh();

      if (!mounted) return;
      DialogHelper.hideLoading(context);

      MainRoute().go(context);
    } catch (e) {
      DialogHelper.hideLoading(context);
    }
  }

  void onCreateSup() {
    ref.read(postFormControllerProvider.notifier)
      ..type(ContentType.sup)
      ..createdFrom(SupCreatedFromEnum.event);

    PostFormRoute().push(context);
  }

  Future<void> onAddReminder() async {
    await EventHelper.requestPermission();

    if (!mounted) return;

    var duration = await SheetUtils.showSimpleSheet<Duration>(
      context: context,
      isScrollControlled: true,
      child: SelectReminderSheet(),
    );

    if (duration == null) return;

    await EventHelper.createEvent(
      name: data.name,
      eventId: data.uuid,
      reminder: duration,
      endTime: data.endTime,
      location: data.location,
      startTime: data.startTime,
      description: data.description,
    );

    Toast.success('Event reminder added');
  }

  void onShareTap() {
    Share.share('Check out this event ${getEventShareUrl(data.uuid)}');
  }

  Future<void> onAcceptTap(String uuid) async {
    await SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(
        confirmText: 'Confirm',
        title: 'YOU ARE ACCEPTING THIS EVENT, ARE YOU SURE?',
        onDelete: () async {
          await ref.read(eventControllerProvider.notifier).accept(
                performerUuid: uuid,
                eventUuid: data.uuid,
                creatorUuid: data.profileUuid,
              );

          Toast.success('Event accepted');

          if (mounted) {
            context.pop();
            context.pop();
          }
        },
      ),
    );
  }

  Future<void> onRejectTap(String uuid) async {
    await SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(
        confirmText: 'Confirm',
        title: 'YOU ARE REJECTING THIS EVENT, ARE YOU SURE?',
        onDelete: () async {
          await ref.read(eventControllerProvider.notifier).reject(
                performerUuid: uuid,
                eventUuid: data.uuid,
                creatorUuid: data.profileUuid,
              );

          Toast.success('Event rejected');

          if (mounted) {
            context.pop();
            context.pop();
          }
        },
      ),
    );
  }

  void viewEvent() {
    var viewerUuid = ref.read(profileControllerProvider).value!.uuid;
    var controller = ref.read(
      eventMetadataControllerProvider(
        eventUuid: data.uuid,
        viewerUuid: viewerUuid,
      ).notifier,
    );

    controller.view();
  }
}
