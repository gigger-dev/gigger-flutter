import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/get_giglist_thumbnail_url.dart';
import 'package:mobile_gigger_app/features/home/providers/all_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/event_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_giglist_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/home/widgets/video_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllWidget extends ConsumerWidget {
  const AllWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;
    var profile = ref.watch(profileControllerProvider).value!;

    var items = ref.watch(allControllerProvider);

    var videoState = ref.watch(recommendedVideoControllerProvider);
    var giglistState = ref.watch(recommendedGiglistControllerProvider);
    var eventState = ref.watch(eventControllerProvider);

    var videos = videoState.whenData((v) => v.items).valueOrNull ?? [];
    var giglists = giglistState.whenData((v) => v.items).valueOrNull ?? [];
    var events = eventState.whenData((v) => v.items).valueOrNull ?? [];

    var isLoading =
        videoState.isLoading || giglistState.isLoading || eventState.isLoading;

    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: isLoading ? 6 : items.length,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 100),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: .55,
        ),
        itemBuilder: (context, int index) {
          if (isLoading) return AllArtistItem(profile, cdnUrl);

          var data = items[index];

          if (data is ProfileOut) {
            return AllArtistItem(data, cdnUrl);
          }

          if (data is PostOut) {
            return VideoItem(
              items: videos,
              cdnUrl: cdnUrl,
              viewCount: data.viewCount,
              index: videos.indexOf(data),
              thumbnailUrl: data.thumbnailUrl,
            );
          }

          if (data is GigListOut) {
            return AllGiglistItem(data, cdnUrl, giglists);
          }

          if (data is EventOut) {
            return AllEventItem(
              data: data,
              cdnUrl: cdnUrl!,
              index: events.indexOf(data),
            );
          }

          return null;
        },
      ),
    );
  }
}

class AllArtistItem extends StatelessWidget {
  const AllArtistItem(this.data, this.cdnUrl, {super.key});

  final String? cdnUrl;
  final ProfileOut data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ProfileRoute(uuid: data.uuid).push(context),
      child: Container(
        decoration: BoxDecoration(
          color: colorGrey,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider('$cdnUrl/${data.coverMedia}'),
          ),
        ),
        padding: EdgeInsets.all(4),
        alignment: Alignment.bottomLeft,
        child: TextViewWidget(
          text: data.account.username,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          textSize: 14,
        ),
      ),
    );
  }
}

class AllGiglistItem extends StatelessWidget {
  const AllGiglistItem(this.data, this.cdnUrl, this.items, {super.key});

  final String? cdnUrl;
  final GigListOut data;
  final List<GigListOut> items;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GiglistScrollRoute(index: items.indexOf(data)).push(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorGrey,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              getGiglistThumbnailUrl(
                cdnUrl: cdnUrl ?? '',
                thumbnailUrl: data.thumbnailUrl,
                gigListMedia: data.gigListMedia,
              ),
            ),
          ),
        ),
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorWhite),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(6),
                child: TextViewWidget(
                  text: data.isLookingFor ? 'I look for' : 'I offer',
                  textSize: 8,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: TextViewWidget(
                text: data.title,
                textSize: 14,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllEventItem extends StatelessWidget {
  const AllEventItem({
    super.key,
    required this.data,
    required this.cdnUrl,
    required this.index,
  });

  final int index;
  final String cdnUrl;
  final EventOut data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => EventScrollRoute(index: index).push(context),
      child: Container(
        decoration: BoxDecoration(
          color: colorGrey,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider('$cdnUrl/${data.thumbnailUrl}'),
          ),
        ),
        alignment: Alignment.topRight,
        padding: const EdgeInsets.all(4),
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
    );
  }
}
