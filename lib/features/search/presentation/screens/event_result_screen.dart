import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/shimmer_utils.dart';
import 'package:mobile_gigger_app/features/home/providers/event_controller.dart';
import 'package:mobile_gigger_app/features/home/widgets/event_widget.dart';
import 'package:mobile_gigger_app/features/search/controllers/event_search_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class EventResultScreen extends ConsumerStatefulWidget {
  const EventResultScreen({super.key, required this.keyword});

  final String keyword;

  @override
  ConsumerState<EventResultScreen> createState() => _EventResultScreenState();
}

class _EventResultScreenState extends ConsumerState<EventResultScreen> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;
    var state = ref.watch(eventSearchControllerProvider(
      keyword: widget.keyword,
    ));

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('All Results')),
      body: EasyRefresh(
        onRefresh: onRefresh,
        header: MaterialHeader(),
        triggerAxis: Axis.vertical,
        child: state.when(
          loading: () => CircularLoading(),
          error: (error, stackTrace) => ShimmerUtils.topVideoList,
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                child:
                    TextViewWidget(text: 'No Result Found', color: colorGrey),
              );
            }

            return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              itemCount: data.length,
              padding: const EdgeInsets.all(10),
              staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
              itemBuilder: (context, index) {
                return EventItem(
                  index: index,
                  data: data[index],
                  cdnUrl: cdnUrl ?? '',
                  onTap: () => onTap(data, index),
                );
              },
            );
          },
        ),
      ),
    );
  }

  FutureOr onRefresh() {
    ref
        .read(eventSearchControllerProvider(keyword: widget.keyword).notifier)
        .refresh();
  }

  Future<void> onTap(List<EventOut> data, int index) async {
    await ref.read(eventControllerProvider.notifier).insertItem(data[index]);

    if (mounted) {
      EventScrollRoute(index: index).push(context);
    }
  }
}
