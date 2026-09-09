import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/connection/providers/following_controller.dart';
import 'package:mobile_gigger_app/features/connection/widgets/following_item.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';

class FollowingWidget extends ConsumerWidget {
  const FollowingWidget(this.uuid, {super.key});

  final String uuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(followingControllerProvider(uuid));

    return state.when(
      loading: () => CircularLoading(),
      error: (error, stackTrace) => SizedBox(),
      data: (data) => ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        itemCount: data.items.length,
        separatorBuilder: (_, __) => SizedBox(height: 10),
        itemBuilder: (context, index) {
          return FollowingItem(
            uuid: uuid,
            data: data.items[index],
          );
        },
      ),
    );
  }
}
