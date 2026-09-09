import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/core/utils/time_ago.dart';
import 'package:mobile_gigger_app/features/home/providers/event_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_giglist_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_video_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/sup_controller.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/noti_read_controller.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/notification_controller.dart';
import 'package:mobile_gigger_app/features/sup/sup_all_screen.dart';
import 'package:mobile_gigger_app/features/video_player/providers/video_controller.dart';
import 'package:mobile_gigger_app/models/notification_out.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';

class NotificationItem extends ConsumerWidget {
  const NotificationItem({
    required this.data,
    super.key,
    required this.cdnUrl,
  });

  final String cdnUrl;
  final NotificationOut data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var child = ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      onTap: () => onTap(context, ref),
      onLongPress: () => onLongPress(context, ref),
      leading: IconButton(
        onPressed: () async {
          if (data.data is Map && data.data.containsKey('profile_uuid')) {
            ProfileRoute(uuid: data.data['profile_uuid']).push(context);
          }
        },
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
        ),
        icon: CircleAvatar(
          radius: 18,
          backgroundColor: colorRed,
          backgroundImage: CachedNetworkImageProvider(
            '$cdnUrl/${data.data['profile_image']}',
          ),
        ),
      ),
      title: TextViewWidget(
        text: data.body.isEmpty ? data.title : data.body,
        textSize: 13.sp,
      ),
      trailing: TextViewWidget(
        text: timeAgo(data.createdAt.toLocal()),
        textSize: 12,
      ),
      // subtitle: TextViewWidget(
      //   textSize: 12,
      //   maxLines: 2,
      //   text: data.body,
      //   textOverflow: TextOverflow.ellipsis,
      // ),
    );

    var items = ref.watch(notiReadControllerProvider).valueOrNull ?? [];

    var isRead = items.contains(jsonEncode(data.toJson()));

    if (isRead) return Opacity(opacity: .5, child: child);

    return child;
  }

  Future<void> onTap(BuildContext context, WidgetRef ref) async {
    log(jsonEncode(data.toJson()));
    ref.read(notiReadControllerProvider.notifier).read(data);

    var uuid = data.data['uuid'];

    switch (data.notificationType) {
      case 0:
      case 1:
        ConnectionRoute().push(context);
        break;
      case 2:
        ChatRoute(uuid: uuid).push(context);
        break;
      case 12:
      case 13:
        if (data.body.toLowerCase().contains('event') ||
            data.data['notification_data_type'] == 4) {
          goToEvent(uuid, context, ref);
        } else {
          ConnectionRoute().push(context);
        }
        break;
      case 11:
        goWithDataType(context, ref, data.data, data.body.toLowerCase());
        break;
      // case 4:
      // case 14:
      //   await goToRoute(context, ref);
      //   break;

      default:
        await goToRoute(context, ref);
    }
  }

  Future<void> goToRoute(BuildContext context, WidgetRef ref) async {
    var uuid = data.data['uuid'];
    if (uuid == null) return;

    var body = data.body.toLowerCase();

    if (body.contains('giglist!')) {
      return goToGigList(ref, uuid, context);
    }

    if (body.contains('post!')) {
      return goToPost(ref, uuid, context);
    }

    if (body.contains('sup!')) {
      return goToSup(ref, uuid, context);
    }
  }

  Future<void> goToPost(WidgetRef ref, uuid, BuildContext context) async {
    var index = await ref
        .read(recommendedVideoControllerProvider.notifier)
        .getById(uuid);

    if (index == null) return;

    var state = await ref.read(recommendedVideoControllerProvider.future);
    ref.read(videoControllerProvider.notifier).items(state.items);

    if (!context.mounted) return;
    VideoPlayerRoute(index: index).push(context);
  }

  Future<void> goToEvent(
    String uuid,
    BuildContext context,
    WidgetRef ref,
  ) async {
    var index = await ref.read(eventControllerProvider.notifier).getById(uuid);
    if (index == null) return;

    if (!context.mounted) return;

    EventScrollRoute(index: index).push(context);
  }

  Future<void> onLongPress(BuildContext context, WidgetRef ref) async {
    var r = await SheetUtils.showSimpleSheet<bool>(
      context: context,
      child: ConfirmDialog(
        title: 'Are you sure you want to delete this notification?',
        confirmText: 'Yes delete',
        cancelText: 'Cancel',
      ),
    );

    if (r == true) {
      ref.read(notiReadControllerProvider.notifier).delete(data.id);
      await ref.read(notificationControllerProvider.notifier).delete(data.id);
    }
  }

  void goWithDataType(
    BuildContext context,
    WidgetRef ref,
    dynamic data,
    String body,
  ) {
    var uuid = data['uuid'] as String;

    var type = data['notification_data_type'] as int?;

    if (type == 0 || body.contains('profile')) {
      ProfileRoute(uuid: uuid).push(context);
      return;
    }

    if (type == 1 || body.contains('post')) {
      goToPost(ref, uuid, context);
      return;
    }
    if (type == 2 || body.contains('giglist')) {
      goToGigList(ref, uuid, context);
      return;
    }
    if (type == 3 || body.contains('sup')) {
      goToSup(ref, uuid, context);
      return;
    }
    if (type == 4 || body.contains('event')) {
      goToEvent(uuid, context, ref);
      return;
    }
  }

  Future<void> goToGigList(WidgetRef ref, uuid, BuildContext context) async {
    var index = await ref
        .read(recommendedGiglistControllerProvider.notifier)
        .getById(uuid);

    if (!context.mounted) return;
    GiglistScrollRoute(index: index).push(context);
  }

  Future<void> goToSup(WidgetRef ref, uuid, BuildContext context) async {
    var data = await ref.read(getSupByIdProvider(uuid).future);

    var sups = await ref.read(
      supProfileControllerProvider(data.profileUuid, data.createFrom).future,
    );

    var index = sups.indexWhere((e) => e.uuid == data.uuid);

    if (index == -1) {
      Toast.error('Your Sup has been expired');
      return;
    }

    if (!context.mounted) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorTransparent,
      builder: (context) => SupAllScreen(index: index),
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.cancelText,
    required this.confirmText,
  });

  final String title;
  final String cancelText;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: TextViewWidget(
              text: title,
              textSize: 23,
              height: 1.2,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          OutlinedBtn(
            onPressed: () => context.pop(false),
            text: cancelText,
          ),
          const SizedBox(height: 8),
          GradientFilledButton(
            title: confirmText,
            onPressed: () => context.pop(true),
          )
        ],
      ),
    );
  }
}
