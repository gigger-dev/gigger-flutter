import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/home/widgets/video_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/search/controllers/video_search_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/features/video_player/providers/video_controller.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class VideoResultScreen extends ConsumerStatefulWidget {
  const VideoResultScreen({
    super.key,
    required this.title,
    required this.genre,
    required this.keywords,
  });

  final String title;
  final String? genre;
  final String keywords;

  @override
  ConsumerState<VideoResultScreen> createState() => _VideoResultScreenState();
}

class _VideoResultScreenState extends ConsumerState<VideoResultScreen> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;
    var uuid = ref.watch(profileControllerProvider).value!.uuid;

    var state = ref.watch(videoSearchControllerProvider(
      title: widget.title,
      keywords: widget.keywords,
      searcherUuid: uuid,
      genre: widget.genre,
    ));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Video Results'),
      ),
      body: EasyRefresh(
        header: MaterialHeader(),
        triggerAxis: Axis.vertical,
        onRefresh: () => onRefresh(uuid),
        child: state.when(
          loading: () => CircularLoading(),
          error: (error, stackTrace) => Text('$error, $stackTrace'),
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                child: TextViewWidget(
                  text: 'No Result Found',
                  color: colorGrey,
                ),
              );
            }

            return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              itemCount: data.length,
              padding: const EdgeInsets.all(10),
              staggeredTileBuilder: (int index) {
                if (index % 6 == 4) return const StaggeredTile.fit(2);
                if (index % 6 == 5) return const StaggeredTile.fit(3);
                return const StaggeredTile.fit(1);
              },
              itemBuilder: (context, int index) {
                return VideoItem(
                  index: index,
                  cdnUrl: cdnUrl,
                  onTap: () => onTap(data[index]),
                  viewCount: data[index].viewCount,
                  thumbnailUrl: data[index].thumbnailUrl,
                );
              },
            );
          },
        ),
      ),
    );
  }

  FutureOr onRefresh(String uuid) {
    ref
        .read(videoSearchControllerProvider(
          searcherUuid: uuid,
          title: widget.title,
          genre: widget.genre,
          keywords: widget.keywords,
        ).notifier)
        .refresh();
  }

  Future<void> onTap(PostOut data) async {
    var e = await ref
        .read(recommendedVideoControllerProvider.notifier)
        .checkAndInsert(data);

    ref
        .read(videoControllerProvider.notifier)
        .items(e.index == 0 ? [data, ...e.items] : e.items);

    if (!mounted) return;
    VideoPlayerRoute(index: e.index).push(context);
  }
}
