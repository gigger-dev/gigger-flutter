import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/shimmer_utils.dart';
import 'package:mobile_gigger_app/features/home/widgets/all_widget.dart';
import 'package:mobile_gigger_app/features/home/widgets/video_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/search/controllers/all_search_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class AllResultScreen extends ConsumerStatefulWidget {
  const AllResultScreen({super.key, required this.keyword});

  final String keyword;

  @override
  ConsumerState<AllResultScreen> createState() => _AllResultScreenState();
}

class _AllResultScreenState extends ConsumerState<AllResultScreen> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;

    var uuid = ref.watch(profileControllerProvider).value!.uuid;
    var state = ref.watch(allSearchControllerProvider(
      keyword: widget.keyword,
      searcherUuid: uuid,
    ));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('All Results'),
      ),
      body: EasyRefresh(
        onRefresh: () => onRefresh(uuid),
        header: MaterialHeader(),
        triggerAxis: Axis.vertical,
        child: state.when(
          loading: () => CircularLoading(),
          error: (error, stackTrace) => ShimmerUtils.topVideoList,
          data: (data) {
            if (data.items.isEmpty) {
              return const Center(
                child: TextViewWidget(
                  text: 'No Result Found',
                  color: colorGrey,
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              itemCount: data.items.length,
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                childAspectRatio: .55,
              ),
              itemBuilder: (context, index) {
                var e = data.items[index];

                if (e is ProfileOut) {
                  return AllArtistItem(e, cdnUrl);
                }

                if (e is PostOut) {
                  return VideoItem(
                    cdnUrl: cdnUrl,
                    viewCount: e.viewCount,
                    items: data.results.posts,
                    thumbnailUrl: e.thumbnailUrl,
                    index: data.results.posts.indexOf(e),
                  );
                }

                if (e is GigListOut) {
                  return AllGiglistItem(e, cdnUrl, data.results.gigList);
                }

                return null;
              },
            );
          },
        ),
      ),
    );
  }

  void onRefresh(String uuid) {
    ref
        .read(allSearchControllerProvider(
          keyword: widget.keyword,
          searcherUuid: uuid,
        ).notifier)
        .refresh();
  }
}
