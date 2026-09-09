import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/shimmer_utils.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/search/controllers/gigger_search_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class GiggerResultScreen extends ConsumerStatefulWidget {
  const GiggerResultScreen({
    super.key,
    required this.name,
    required this.isPro,
    required this.role,
    required this.genre,
    required this.instrument,
    required this.startDate,
    required this.endDate,
  });

  final bool isPro;
  final String? name;
  final String? role;
  final String? genre;
  final String? instrument;

  final DateTime? startDate;
  final DateTime? endDate;

  @override
  ConsumerState<GiggerResultScreen> createState() => _GiggerResultScreenState();
}

class _GiggerResultScreenState extends ConsumerState<GiggerResultScreen> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;

    var profileUuid = ref.watch(profileControllerProvider).value!.uuid;

    var state = ref.watch(giggerSearchControllerProvider(
      role: widget.role,
      genre: widget.genre,
      username: widget.name,
      endDate: widget.endDate,
      profileUuid: profileUuid,
      proUserOnly: widget.isPro,
      startDate: widget.startDate,
      instrument: widget.instrument,
    ));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gigger Results'),
      ),
      body: EasyRefresh(
        onRefresh: onRefresh,
        header: MaterialHeader(),
        triggerAxis: Axis.vertical,
        child: state.when(
          loading: () => CircularLoading(),
          error: (error, stackTrace) => ShimmerUtils.topVideoList,
          data: (data) {
            if (data.items.isEmpty) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: .8.sh,
                  child: const Center(
                    child: TextViewWidget(
                      text: 'No Result Found',
                      color: colorGrey,
                    ),
                  ),
                ),
              );
            }

            return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              itemCount: data.items.length,
              padding: const EdgeInsets.all(10),
              staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
              itemBuilder: (context, int index) {
                return Padding(
                  padding: EdgeInsets.only(top: index.isOdd ? 30 : 0),
                  child: _ArtistItem(data.items[index], cdnUrl),
                );
              },
            );
          },
        ),
      ),
    );
  }

  FutureOr<void> onRefresh() {
    var profileUuid = ref.read(profileControllerProvider).value!.uuid;

    ref
        .read(giggerSearchControllerProvider(
          role: widget.role,
          genre: widget.genre,
          username: widget.name,
          profileUuid: profileUuid,
          proUserOnly: widget.isPro,
        ).notifier)
        .refresh();
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
