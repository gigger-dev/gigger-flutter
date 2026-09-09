import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_giglist_controller.dart';
import 'package:mobile_gigger_app/features/home/widgets/giglist_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/search/controllers/giglist_search_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class GiglistResultScreen extends ConsumerStatefulWidget {
  const GiglistResultScreen({
    super.key,
    required this.title,
    required this.isLookingFor,
    required this.isPerformer,
    required this.price,
  });

  final num? price;
  final String title;
  final bool isPerformer;
  final bool isLookingFor;

  @override
  ConsumerState<GiglistResultScreen> createState() =>
      _GiglistResultScreenState();
}

class _GiglistResultScreenState extends ConsumerState<GiglistResultScreen> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;
    var uuid = ref.watch(profileControllerProvider).value!.uuid;
    var state = ref.watch(giglistSearchControllerProvider(
      searcherUuid: uuid,
      title: widget.title,
      price: widget.price,
      isPerformer: widget.isPerformer,
      isLookingFor: widget.isLookingFor,
    ));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GigList Results'),
      ),
      body: EasyRefresh(
        onRefresh: () => onRefresh(uuid),
        header: MaterialHeader(),
        triggerAxis: Axis.vertical,
        child: state.when(
          loading: () => CircularLoading(),
          error: (error, _) => Text('$error'),
          data: (data) {
            if (data.items.isEmpty) {
              return const Center(
                child: TextViewWidget(
                  text: 'No Result Found',
                  color: colorGrey,
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
                var e = data.items[index];

                return Padding(
                  padding: EdgeInsets.only(top: index.isOdd ? 30 : 0),
                  child: GiglistItem(
                    cdnUrl: cdnUrl,
                    title: e.title,
                    isLookingFor: e.isLookingFor,
                    gigListMedia: e.gigListMedia,
                    thumbnailUrl: e.thumbnailUrl,
                    wageRequested: e.wageRequested,
                    onTap: () async {
                      var _index = await ref
                          .read(recommendedGiglistControllerProvider.notifier)
                          .getIndexByData(e);

                      if (!context.mounted) return;
                      GiglistScrollRoute(index: _index).push(context);
                    },
                  ),
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
        .read(giglistSearchControllerProvider(
          searcherUuid: uuid,
          title: widget.title,
          price: widget.price,
          isPerformer: widget.isPerformer,
          isLookingFor: widget.isLookingFor,
        ).notifier)
        .refresh();
  }
}
