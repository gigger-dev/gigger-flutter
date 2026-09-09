import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/home/providers/artist_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArtistWidget extends ConsumerStatefulWidget {
  const ArtistWidget({super.key});

  @override
  ConsumerState<ArtistWidget> createState() => _ArtistWidgetState();
}

class _ArtistWidgetState extends ConsumerState<ArtistWidget> {
  @override
  Widget build(BuildContext context) {
    var profile = ref.watch(profileControllerProvider).value!;

    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;
    var state = ref.watch(artistControllerProvider);

    return state.when(
      error: (error, stackTrace) => Skeletonizer(
        child: _GridView(
          itemCount: 4,
          cdnUrl: cdnUrl,
          itemGetter: (_) => profile,
        ),
      ),
      loading: () => Skeletonizer(
        child: _GridView(
          itemCount: 4,
          cdnUrl: cdnUrl,
          itemGetter: (_) => profile,
        ),
      ),
      data: (data) => _GridView(
        cdnUrl: cdnUrl,
        itemCount: data.items.length,
        itemGetter: (i) => data.items[i],
      ),
    );
  }
}

typedef ItemGetter = ProfileOut Function(int i);

class _GridView extends StatelessWidget {
  const _GridView({
    required this.itemCount,
    required this.cdnUrl,
    required this.itemGetter,
  });

  final int itemCount;
  final String? cdnUrl;
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
      itemBuilder: (context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: index.isOdd ? 30 : 0),
          child: _ArtistItem(itemGetter(index), cdnUrl),
        );
      },
    );
  }
}

class _ArtistItem extends StatelessWidget {
  const _ArtistItem(this.data, this.cdnUrl);

  final String? cdnUrl;
  final ProfileOut data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ProfileRoute(uuid: data.uuid).push(context);
      },
      child: Column(
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: colorGrey,
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider('$cdnUrl/${data.coverMedia}'),
              ),
            ),
            alignment: Alignment.topLeft,
            child: !data.availabilityStatus
                ? null
                : Padding(
                    padding: const EdgeInsets.all(8),
                    child: Skeleton.ignore(
                      child: Row(
                        children: [
                          Container(
                            height: 9,
                            width: 9,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                              boxShadow: [
                                BoxShadow(
                                  color: colorBlack,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Available!',
                            style: TextStyle(
                              color: colorWhite,
                              fontSize: 10,
                              shadows: [Shadow(color: colorBlack)],
                            ),
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
                Text(
                  data.account.username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: colorWhite, fontSize: 14),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: const Icon(
                        Icons.location_on,
                        color: colorWhite,
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        '${data.location.city} - ${data.location.state}',
                        style: const TextStyle(color: colorWhite, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  data.bio,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
