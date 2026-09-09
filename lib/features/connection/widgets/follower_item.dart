import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/connection/providers/follower_controller.dart';
import 'package:mobile_gigger_app/features/connection/providers/following_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/get_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/metadata_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class FollowerItem extends ConsumerStatefulWidget {
  const FollowerItem({
    super.key,
    required this.data,
    required this.uuid,
  });

  final String uuid;
  final ProfileFewerDetailsOut data;

  @override
  ConsumerState<FollowerItem> createState() => _FollowerItemState();
}

class _FollowerItemState extends ConsumerState<FollowerItem> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).value!.cdnUrl;

    return ListTile(
      dense: true,
      onTap: () => ProfileRoute(uuid: widget.data.uuid).push(context),
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: colorGrey,
        backgroundImage: CachedNetworkImageProvider(
          '$cdnUrl/${widget.data.avatarMedia}',
        ),
      ),
      title: TextViewWidget(
        text: widget.data.account.username,
        textSize: 16,
      ),
      trailing: actionBtn(),
    );
  }

  Widget actionBtn() {
    var isPrivate = widget.data.isPrivateProfile;
    var isFollowedBack = widget.data.isFollowedBack ?? false;
    var isFollowRequest = widget.data.isFollowRequestAlreadySent ?? false;

    return ElevatedButton(
      onPressed: () => onTap(isFollowedBack, isFollowRequest),
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        side: !isFollowedBack && !isFollowRequest
            ? null
            : BorderSide(color: colorWhite, width: .5),
        backgroundColor: isFollowedBack || isFollowRequest ? null : colorRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      child: TextViewWidget(
        text: isFollowRequest
            ? 'Cancel Request'
            : isFollowedBack
                ? 'Remove'
                : isPrivate
                    ? 'Req. sent'
                    : 'Follow back',
      ),
    );
  }

  Future<void> onTap(
    bool isFollowedBack,
    bool isFollowRequest,
  ) async {
    DialogHelper.showOverlay(context);

    if (isFollowedBack || isFollowRequest) {
      await ref
          .read(getProfileControllerProvider(widget.data.uuid).notifier)
          .unfollow();
    } else {
      await ref
          .read(getProfileControllerProvider(widget.data.uuid).notifier)
          .follow();
    }

    ref.read(followingControllerProvider(widget.uuid).notifier).refresh();
    ref.read(followerControllerProvider(widget.uuid).notifier).refresh();
    ref.read(metadataControllerProvider(widget.uuid).notifier).refresh();

    if (mounted) DialogHelper.hideLoading(context);
  }
}
