import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/connection/providers/unfollow_list_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/get_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/metadata_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class FollowingItem extends ConsumerWidget {
  const FollowingItem({super.key, required this.uuid, required this.data});

  final String uuid;
  final ProfileFewerDetailsOut data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cdnUrl = ref.watch(configProvider).value!.cdnUrl;

    var unfollowList = ref.watch(unfollowListControllerProvider);

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      onTap: () => ProfileRoute(uuid: data.uuid).push(context),
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: colorGrey,
        backgroundImage: CachedNetworkImageProvider(
          '$cdnUrl/${data.avatarMedia}',
        ),
      ),
      title: TextViewWidget(text: data.account.username, textSize: 16),
      trailing: actionBtn(ref, unfollowList.contains(data.uuid)),
    );
  }

  Widget actionBtn(WidgetRef ref, bool isUnfollow) {
    return ElevatedButton(
      onPressed: () => onTap(ref, isUnfollow),
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        backgroundColor: isUnfollow ? colorRed : null,
        side: isUnfollow ? null : BorderSide(color: colorWhite, width: .5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      child: TextViewWidget(text: isUnfollow ? 'Follow' : 'Unfollow'),
    );
  }

  Future<void> onTap(WidgetRef ref, bool isUnfollow) async {
    if (isUnfollow) {
      await ref.read(getProfileControllerProvider(data.uuid).notifier).follow();

      ref.read(unfollowListControllerProvider.notifier).remove(data.uuid);
    } else {
      await ref
          .read(getProfileControllerProvider(data.uuid).notifier)
          .unfollow();

      ref.read(unfollowListControllerProvider.notifier).add(data.uuid);
    }

    ref.read(metadataControllerProvider(uuid).notifier).refresh();
  }
}
