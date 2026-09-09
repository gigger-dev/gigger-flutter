import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/connection/providers/follower_controller.dart';
import 'package:mobile_gigger_app/features/connection/widgets/follower_item.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';

class FollowerWidget extends ConsumerWidget {
  const FollowerWidget(this.uuid, {super.key});

  final String uuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(followerControllerProvider(uuid));

    return state.when(
      error: (error, stackTrace) => SizedBox(),
      loading: () => CircularLoading(),
      data: (data) => ListView.separated(
        shrinkWrap: true,
        itemCount: data.items.length,
        padding: EdgeInsets.all(20),
        separatorBuilder: (_, __) => SizedBox(height: 10),
        itemBuilder: (context, index) {
          return FollowerItem(
            data: data.items[index],
            uuid: uuid,
          );
        },
      ),
    );
  }
}
