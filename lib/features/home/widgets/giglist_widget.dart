import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/get_giglist_thumbnail_url.dart';
import 'package:mobile_gigger_app/core/utils/num_format.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_giglist_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/gig_list_media.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GiglistWidget extends ConsumerStatefulWidget {
  const GiglistWidget({super.key});

  @override
  ConsumerState<GiglistWidget> createState() => _GiglistWidgetState();
}

class _GiglistWidgetState extends ConsumerState<GiglistWidget> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;
    var state = ref.watch(recommendedGiglistControllerProvider);

    return state.when(
      error: (error, stackTrace) => Text('$error'),
      loading: () => Skeletonizer(child: GiglistGridView(itemCount: 4)),
      data: (data) => GiglistGridView(
        cdnUrl: cdnUrl,
        itemCount: data.items.length,
        title: (i) => data.items[i].title,
        location: (i) => data.items[i].location,
        gigListMedia: (i) => data.items[i].gigListMedia,
        isLookingFor: (i) => data.items[i].isLookingFor,
        thumbnailUrl: (i) => data.items[i].thumbnailUrl,
        wageRequested: (i) => data.items[i].wageRequested,
      ),
    );
  }
}

typedef OnTapCallBack = void Function(int i);
typedef TitleCallBack = String Function(int i);
typedef IsLookingForCallBack = bool Function(int i);
typedef WageRequestedCallBack = num? Function(int i);
typedef ThumbnailUrlCallBack = String Function(int i);
typedef LocationCallBack = String Function(int i);
typedef GigListMediaCallBack = Map<String, GigListMedia> Function(int i);

class GiglistGridView extends StatelessWidget {
  const GiglistGridView({
    super.key,
    required this.itemCount,
    this.title,
    this.cdnUrl,
    this.physics,
    this.gigListMedia,
    this.isLookingFor,
    this.thumbnailUrl,
    this.wageRequested,
    this.isFav,
    this.profileUuid,
    this.location,
    this.shrinkWrap = false,
  });

  final bool? isFav;
  final int itemCount;
  final String? cdnUrl;
  final bool shrinkWrap;
  final String? profileUuid;
  final TitleCallBack? title;
  final ScrollPhysics? physics;
  final LocationCallBack? location;
  final IsLookingForCallBack? isLookingFor;
  final GigListMediaCallBack? gigListMedia;
  final ThumbnailUrlCallBack? thumbnailUrl;
  final WageRequestedCallBack? wageRequested;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      itemCount: itemCount,
      shrinkWrap: shrinkWrap,
      physics: physics ?? NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 200),
      staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
      itemBuilder: (context, i) => Padding(
        padding: EdgeInsets.only(top: i.isOdd ? 30 : 0),
        child: GiglistItem(
          index: i,
          isFav: isFav,
          cdnUrl: cdnUrl,
          profileUuid: profileUuid,
          title: title?.call(i) ?? '',
          location: location?.call(i),
          thumbnailUrl: thumbnailUrl?.call(i),
          gigListMedia: gigListMedia?.call(i),
          wageRequested: wageRequested?.call(i),
          isLookingFor: isLookingFor?.call(i) ?? false,
        ),
      ),
    );
  }
}

class GiglistItem extends StatelessWidget {
  const GiglistItem({
    this.index,
    this.cdnUrl,
    super.key,
    this.onTap,
    this.thumbnailUrl,
    this.gigListMedia,
    required this.isLookingFor,
    required this.title,
    this.wageRequested,
    this.profileUuid,
    this.isFav,
    this.location,
  });

  final int? index;
  final bool? isFav;
  final String title;
  final String? cdnUrl;
  final bool isLookingFor;
  final num? wageRequested;
  final VoidCallback? onTap;
  final String? thumbnailUrl;
  final String? profileUuid;
  final String? location;
  final Map<String, GigListMedia>? gigListMedia;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () => index == null
              ? null
              : GiglistScrollRoute(
                  index: index!,
                  isFav: isFav,
                  profileUuid: profileUuid,
                ).push(context),
      child: Column(
        children: [
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: colorGrey,
              borderRadius: BorderRadius.circular(14),
              image: thumbnailUrl == null || gigListMedia == null
                  ? null
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        getGiglistThumbnailUrl(
                          cdnUrl: cdnUrl!,
                          thumbnailUrl: thumbnailUrl!,
                          gigListMedia: gigListMedia!,
                        ),
                      ),
                    ),
            ),
            padding: EdgeInsets.all(8),
            alignment: Alignment.topRight,
            child: Skeleton.leaf(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorWhite),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(6),
                child: TextViewWidget(
                  text: isLookingFor ? 'I look for' : 'I offer',
                  textSize: 8,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: colorWhite, fontSize: 14),
                ),
                TextViewWidget(
                  text:
                      'Wage: ${isLookingFor ? 'See description' : numFormat(wageRequested) == null ? 'ND' : '${numFormat(wageRequested)} €'}',
                  textSize: 10,
                ),
                const SizedBox(height: 2),
                if (location != null && location!.isNotEmpty)
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: colorGrey, size: 12),
                      const SizedBox(width: 3),
                      Expanded(
                        child: TextViewWidget(
                          text: location!,
                          textSize: 10,
                          color: colorGrey,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
