import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/event_helper.dart';
import 'package:mobile_gigger_app/core/utils/get_share_url.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/event_form/widgets/select_reminder_sheet.dart';
import 'package:mobile_gigger_app/features/events/presentation/widgets/attending_widget.dart';
import 'package:mobile_gigger_app/features/events/presentation/widgets/event_like_btn.dart';
import 'package:mobile_gigger_app/features/events/presentation/widgets/lineup_list_widget.dart';
import 'package:mobile_gigger_app/features/events/presentation/widgets/map_widget.dart';
import 'package:mobile_gigger_app/features/events/presentation/widgets/response_selector.dart';
import 'package:mobile_gigger_app/features/events/presentation/widgets/social_list_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/fab_six_video.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/fab_three_video.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:share_plus/share_plus.dart';

class EventDetailSheet extends ConsumerStatefulWidget {
  const EventDetailSheet(this.data, {super.key});

  final EventOut data;

  @override
  ConsumerState<EventDetailSheet> createState() => _EventDetailSheetState();
}

class _EventDetailSheetState extends ConsumerState<EventDetailSheet> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).value!.cdnUrl;
    var items = ref
            .watch(fabControllerProvider(widget.data.profileUuid))
            .valueOrNull
            ?.items ??
        [];

    var viewerUuid = ref.watch(profileControllerProvider).value!.uuid;

    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: .9,
      minChildSize: .5,
      initialChildSize: .5,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          padding: EdgeInsets.symmetric(vertical: 20),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  MenuItem(
                    image: Assets.images.giShare,
                    label: 'Share',
                    onTap: onShareTap,
                  ),
                  MenuItem(
                    image: Assets.images.giSupport,
                    label: 'Support',
                  ),
                  EventLikeBtn(
                    viewerUuid: viewerUuid,
                    eventUuid: widget.data.uuid,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.sp),
            Center(
              child: TextViewWidget(text: widget.data.name, textSize: 22.sp),
            ),
            SizedBox(height: 40.sp),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 13.sp),
                child: IconTheme(
                  data: IconThemeData(size: 13.sp),
                  child: Row(
                    mainAxisAlignment: widget.data.genre.isEmpty
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: colorWhite),
                          const SizedBox(width: 3),
                          TextViewWidget(text: widget.data.location),
                        ],
                      ),
                      if (widget.data.genre.isNotEmpty)
                        TextViewWidget(text: '@ ${widget.data.genre}'),
                      Row(
                        children: [
                          Icon(CupertinoIcons.clock, color: colorWhite),
                          const SizedBox(width: 3),
                          TextViewWidget(
                            text:
                                'Start ${DateFormat('hh.mma').format(widget.data.startTime.toLocal()).toLowerCase()}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.sp),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextViewWidget(
                    text: widget.data.description,
                    textSize: 13.sp,
                  ),
                  if (widget.data.hashtags.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextViewWidget(
                        text: widget.data.hashtags
                            .map((e) => '#${e.name}')
                            .join(' '),
                        color: colorRed,
                        textSize: 13,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 30.sp),
            LineupListWidget(
              cdnUrl: cdnUrl,
              items: widget.data.lineUpNPerformersOut
                  .where((e) => e.isAccepted)
                  .toList(),
            ),
            SizedBox(height: 30.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextViewWidget(
                        text: 'Business Partners\nand Sponsors',
                        textSize: 12.sp,
                      ),
                      SizedBox(width: 20.sp),
                      AvatarGroup(count: 5),
                      Icon(Icons.more_horiz),
                    ],
                  ),
                  SizedBox(height: 30.sp),
                  ResponseSelector(
                    viewerUuid: viewerUuid,
                    eventUuid: widget.data.uuid,
                  ),
                  SizedBox(height: 40.sp),
                  AttendingWidget(
                    cdnUrl: cdnUrl,
                    viewerUuid: viewerUuid,
                    eventUuid: widget.data.uuid,
                  ),
                  SizedBox(height: 40.sp),
                  ListTile(
                    dense: true,
                    onTap: onAddReminder,
                    contentPadding: EdgeInsets.zero,
                    trailing: Icon(Icons.chevron_right),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextViewWidget(
                          text: 'Add Reminder',
                          color: colorRed,
                          textSize: 13.sp,
                        ),
                        // TextViewWidget(
                        //   text: '1 day before',
                        //   textSize: 12.sp,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.sp),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextViewWidget(text: 'Contact us!', textSize: 13.sp),
                        SizedBox(height: 20.sp),
                        Row(
                          children: [
                            MenuItem(
                              image: Assets.images.whatsappIcon,
                              label: 'Whatsapp',
                              onTap: () {},
                            ),
                            SizedBox(width: 32.w),
                            MenuItem(
                              icon: Icons.phone_outlined,
                              label: 'Tel',
                              onTap: () {},
                            ),
                            SizedBox(width: 32.w),
                            MenuItem(
                              image: Assets.images.giMessage,
                              label: 'Message',
                            ),
                          ],
                        ),
                        SizedBox(height: 40.sp),
                        SocialListWidget(widget.data.socialLinks),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.sp),
            Center(
              child: TextViewWidget(
                text: 'Where is it?',
                textSize: 13.sp,
              ),
            ),
            SizedBox(height: 20.sp),
            MapWidget(
              uuid: widget.data.uuid,
              lat: widget.data.locationLat,
              lng: widget.data.locationLon,
            ),
            SizedBox(height: 40.sp),
            Center(
              child: TextViewWidget(
                text: 'Restaurants and Hotels nearby',
                textSize: 13.sp,
              ),
            ),
            SizedBox(height: 20.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.place_outlined),
                    TextViewWidget(text: 'Booking', textSize: 13.sp),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.place_outlined),
                    TextViewWidget(text: 'TripAdvisor', textSize: 13.sp),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.place_outlined),
                    TextViewWidget(text: 'AirBnB', textSize: 13.sp),
                  ],
                )
              ],
            ),
            SizedBox(height: 40.sp),
            Center(
              child: TextViewWidget(text: 'Need a ride?', textSize: 13.sp),
            ),
            SizedBox(height: 20.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.place_outlined),
                    TextViewWidget(text: 'Uber', textSize: 13.sp),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.local_taxi_outlined),
                    TextViewWidget(text: 'Taxi', textSize: 13.sp),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.person_outline),
                    TextViewWidget(text: 'Driver', textSize: 13.sp),
                  ],
                )
              ],
            ),
            SizedBox(height: 40.sp),
            Center(
              child: TextViewWidget(
                text: 'More from ("Organizer") and ("Venue")',
                textSize: 13.sp,
              ),
            ),
            SizedBox(height: 20.sp),
            FabSixVideo(
              items: items,
              cdnUrl: cdnUrl,
              uuid: widget.data.profileUuid,
              isOwner: false,
              isEditMode: false,
              onDelete: (value) {},
            ),
            SizedBox(height: 40.sp),
            Center(
              child: TextViewWidget(
                text: 'It might also interest you',
                textSize: 13.sp,
              ),
            ),
            SizedBox(height: 20.sp),
            FabThreeVideo(
              items: items,
              cdnUrl: cdnUrl,
              uuid: widget.data.profileUuid,
              isOwner: false,
              isEditMode: false,
              onDelete: (value) {},
            ),
          ],
        );
      },
    );
  }

  void onShareTap() {
    Share.share('Check out this event ${getEventShareUrl(widget.data.uuid)}');
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
      reminder: duration,
      name: widget.data.name,
      eventId: widget.data.uuid,
      endTime: widget.data.endTime,
      location: widget.data.location,
      startTime: widget.data.startTime,
      description: widget.data.description,
    );

    Toast.success('Event reminder added');
  }
}

typedef ImgGetter = String Function(int i);

class AvatarGroup extends StatelessWidget {
  const AvatarGroup({super.key, required this.count, this.imgGetter});

  final int count;
  final ImgGetter? imgGetter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: count == 1 ? 24 : 18.0 * count,
      child: Stack(
        children: List.generate(count, (i) {
          return Positioned(
            left: i == 0 ? 0 : 16.0 * i,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: colorRed,
                shape: BoxShape.circle,
                image: imgGetter == null
                    ? null
                    : DecorationImage(
                        image: CachedNetworkImageProvider(
                          imgGetter!(i),
                        ),
                      ),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade800, offset: Offset(-1, 0)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
