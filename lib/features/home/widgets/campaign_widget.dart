import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/shimmer_utils.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CampaignWidget extends ConsumerWidget {
  const CampaignWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;
    var state = ref.watch(recommendedVideoControllerProvider);

    return state.when(
      error: (error, stackTrace) => Text('$error'),
      loading: () => ShimmerUtils.topVideoList,
      data: (data) {
        var items = List<PostOut>.from(data.items);
        items.shuffle();

        return StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          itemCount: items.length,
          physics: NeverScrollableScrollPhysics(),
          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 200),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: index.isOdd ? 30 : 0),
              child: _CampaignItem(items[index], cdnUrl: cdnUrl),
            );
          },
        );
      },
    );
  }
}

class _CampaignItem extends StatelessWidget {
  const _CampaignItem(this.data, {this.cdnUrl});

  final String? cdnUrl;
  final PostOut data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: colorGrey,
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider('$cdnUrl/${data.thumbnailUrl}'),
            ),
          ),
          padding: EdgeInsets.all(6),
          alignment: Alignment.bottomLeft,
          child: TextViewWidget(text: data.postTitle, textSize: 14),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextViewWidget(text: data.musicTitle, textSize: 13),
              if (data.location.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: colorTextGrey,
                        size: 11,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: TextViewWidget(
                          text: data.location,
                          textSize: 11,
                          maxLines: 1,
                          color: colorTextGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 2),
              TextViewWidget(
                text: data.caption,
                maxLines: 3,
                textSize: 10,
                color: colorTextGrey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
