import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/giglist_fav/controllers/giglist_fav_controller.dart';
import 'package:mobile_gigger_app/features/home/widgets/giglist_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GiglistFavScreen extends ConsumerStatefulWidget {
  const GiglistFavScreen({super.key});

  @override
  ConsumerState<GiglistFavScreen> createState() => _GiglistStarScreenState();
}

class _GiglistStarScreenState extends ConsumerState<GiglistFavScreen> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;
    var profileUuid = ref.watch(profileControllerProvider).value!.uuid;
    var state = ref.watch(giglistFavControllerProvider(profileUuid));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextViewWidget(
          text: 'Favorites Giglist classifieds',
          textSize: 16,
        ),
      ),
      body: EasyRefresh(
        header: MaterialHeader(),
        triggerAxis: Axis.vertical,
        onRefresh: () => onRefresh(profileUuid),
        child: state.when(
          error: (error, stackTrace) => SingleChildScrollView(
            child: SizedBox(
              height: .8.sh,
              child: Center(child: Text('$error')),
            ),
          ),
          loading: () => Skeletonizer(child: GiglistGridView(itemCount: 4)),
          data: (data) {
            if (data.isEmpty) {
              return SizedBox(
                height: .8.sh,
                child: Center(
                  child: TextViewWidget(
                    text: 'EMPTY',
                    color: colorTextGrey,
                  ),
                ),
              );
            }

            return GiglistGridView(
              isFav: true,
              cdnUrl: cdnUrl,
              itemCount: data.length,
              profileUuid: profileUuid,
              physics: ScrollPhysics(),
              title: (i) => data[i].title,
              gigListMedia: (i) => data[i].gigListMedia,
              isLookingFor: (i) => data[i].isLookingFor,
              thumbnailUrl: (i) => data[i].thumbnailUrl,
              wageRequested: (i) => data[i].wageRequested,
            );
          },
        ),
      ),
    );
  }

  FutureOr onRefresh(String profileUuid) {
    ref.read(giglistFavControllerProvider(profileUuid).notifier).refresh();
  }
}
