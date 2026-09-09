import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/noti_read_controller.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/notification_controller.dart';
import 'package:mobile_gigger_app/features/notification/presentation/widgets/notification_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/notification_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class NotificationWidget extends ConsumerWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cdnUrl = ref.watch(configProvider).value!.cdnUrl;
    var state = ref.watch(notificationControllerProvider);

    return EasyRefresh(
      header: MaterialHeader(),
      triggerAxis: Axis.vertical,
      onRefresh: () {
        ref.read(notificationControllerProvider.notifier).refresh();
      },
      child: state.when(
        loading: () => const CircularLoading(),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: TextViewWidget(
                text: 'No notifications',
                color: colorTextGrey,
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) {
              return NotificationItem(cdnUrl: cdnUrl, data: data[index]);
            },
          );
        },
      ),
    );
  }

  void onTap(NotificationOut e, BuildContext context, WidgetRef ref) {
    ref.read(notiReadControllerProvider.notifier).read(e);

    // if (!context.mounted) return;

    // if (e.data is Map && e.data.containsKey('profile_uuid')) {
    //   ProfileRoute(uuid: e.data['profile_uuid']).push(context);
    // }

    // switch (e.notificationType) {
    //   case 0:
    //   case 1:
    //   case 10:
    //     var uuid = e.data['profile_uuid'];
    //     ProfileRoute(uuid: uuid).push(context);
    //     break;
    //   default:
    // }
  }
}
