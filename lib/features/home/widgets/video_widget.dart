import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/video_player/providers/video_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class VideoWidget extends ConsumerStatefulWidget {
  const VideoWidget({super.key});

  @override
  ConsumerState<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends ConsumerState<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;
    var state = ref.watch(recommendedVideoControllerProvider);

    return state.when(
      error: (error, stackTrace) => Text('$error, $stackTrace'),
      loading: () => _GridView(itemCount: 5),
      data: (data) => _GridView(
        cdnUrl: cdnUrl,
        items: data.items,
        itemCount: data.items.length,
        viewCount: (i) => data.items[i].viewCount,
        thumbnailUrl: (i) => data.items[i].thumbnailUrl,
      ),
    );
  }
}

typedef ViewCountGetter = int Function(int i);
typedef ThumbnailGetter = String? Function(int i);

class _GridView extends StatelessWidget {
  const _GridView({
    required this.itemCount,
    this.viewCount,
    this.cdnUrl,
    this.items = const [],
    this.thumbnailUrl,
    this.onTap,
  });

  final int itemCount;
  final String? cdnUrl;
  final List<PostOut> items;
  final VoidCallback? onTap;
  final ViewCountGetter? viewCount;
  final ThumbnailGetter? thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      itemCount: itemCount,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 100),
      staggeredTileBuilder: (int index) {
        if (index % 6 == 4) {
          return const StaggeredTile.fit(2);
        }
        if (index % 6 == 5) {
          return const StaggeredTile.fit(3);
        }
        return const StaggeredTile.fit(1);
      },
      itemBuilder: (context, int index) {
        return VideoItem(
          index: index,
          items: items,
          cdnUrl: cdnUrl,
          viewCount: viewCount?.call(index) ?? 0,
          thumbnailUrl: thumbnailUrl?.call(index),
        );
      },
    );
  }
}

class VideoItem extends ConsumerWidget {
  const VideoItem({
    super.key,
    required this.cdnUrl,
    required this.index,
    this.items = const [],
    this.onTap,
    required this.thumbnailUrl,
    this.viewCount = 0,
  });

  final int index;
  final int viewCount;
  final String? cdnUrl;
  final List<PostOut> items;
  final VoidCallback? onTap;
  final String? thumbnailUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap ??
          () {
            ref.read(videoControllerProvider.notifier).items(items);
            VideoPlayerRoute(index: index).push(context);
          },
      child: SizedBox(
        height: 220,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorGrey,
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    '$cdnUrl/$thumbnailUrl',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 5,
              bottom: 5,
              child: TextViewWidget(
                text: '$viewCount View${viewCount > 1 ? 's' : ''}',
                color: colorWhite,
                textSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
