import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/home/providers/event_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/call_to_action.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventWidget extends ConsumerWidget {
  const EventWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cdnUrl = ref.watch(configProvider).valueOrNull?.cdnUrl ?? '';
    var state = ref.watch(eventControllerProvider);

    return state.when(
      error: (error, _) => SingleChildScrollView(
        child: SizedBox(height: .4.sh, child: Center(child: Text('$error'))),
      ),
      loading: () => Skeletonizer(
        child: _GridView(
          itemCount: 4,
          cdnUrl: cdnUrl,
          itemGetter: (i) => EventOut(
            name: 'name',
            hashtags: [],
            contacts: {},
            uuid: 'uuid',
            genre: 'genre',
            locationLat: 0,
            locationLon: 0,
            ticketPrice: 0,
            socialLinks: {},
            location: 'location',
            currency: 'currency',
            endTime: DateTime.now(),
            lineUpNPerformersOut: [],
            startTime: DateTime.now(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            description: 'description',
            profileUuid: 'profileUuid',
            isMembershipContent: false,
            thumbnailUrl: 'thumbnailUrl',
            onlineEventLink: 'onlineEventLink',
            videoOrImageUrl: 'videoOrImageUrl',
            callToAction: CallToAction(name: 'name', value: 'value'),
          ),
        ),
      ),
      data: (data) {
        if (data.items.isEmpty) {
          return SingleChildScrollView(
            child: SizedBox(
              height: .4.sh,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.event, color: colorTextGrey, size: 26),
                    SizedBox(height: 2),
                    TextViewWidget(
                      text: 'NO EVENT FOUND',
                      color: colorTextGrey,
                      textSize: 12,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return _GridView(
          cdnUrl: cdnUrl,
          itemCount: data.items.length,
          itemGetter: (i) => data.items[i],
        );
      },
    );
  }
}

typedef ItemGetter = EventOut Function(int i);

class _GridView extends StatelessWidget {
  const _GridView({
    required this.itemCount,
    required this.cdnUrl,
    required this.itemGetter,
  });

  final int itemCount;
  final String cdnUrl;
  final ItemGetter itemGetter;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      itemCount: itemCount,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 200),
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: index.isOdd ? 30 : 0),
          child: EventItem(
            data: itemGetter(index),
            cdnUrl: cdnUrl,
            index: index,
          ),
        );
      },
    );
  }
}

class EventItem extends StatelessWidget {
  const EventItem({
    super.key,
    required this.data,
    required this.cdnUrl,
    required this.index,
    this.onTap,
  });

  final int index;
  final String cdnUrl;
  final EventOut data;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => EventScrollRoute(index: index).push(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: colorGrey,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  '$cdnUrl/${data.thumbnailUrl}',
                ),
              ),
            ),
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(4),
            child: Skeleton.leaf(
              child: Container(
                decoration: BoxDecoration(
                  color: colorBtnOrangeRed,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextViewWidget(
                      text: '${data.startTime.toLocal().day}',
                      color: colorWhite,
                      textSize: 14,
                      height: 1,
                    ),
                    TextViewWidget(
                      text: DateFormat.MMM().format(data.startTime.toLocal()),
                      color: colorWhite,
                      textSize: 10,
                      height: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextViewWidget(text: data.name, textSize: 13),
                Row(
                  children: [
                    if (data.genre.isNotEmpty)
                      Expanded(
                        child: TextViewWidget(
                          text: '@${data.genre}',
                          textSize: 11,
                        ),
                      ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, size: 11),
                          Expanded(
                            child: TextViewWidget(
                              text: data.location,
                              textSize: 11,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TextViewWidget(
                  text: DateFormat('EE d MMM - ')
                          .format(data.startTime.toLocal()) +
                      DateFormat('hh.mma')
                          .format(data.startTime.toLocal())
                          .toLowerCase(),
                  textSize: 11,
                  maxLines: 1,
                  color: colorTextGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
