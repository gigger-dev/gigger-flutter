import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/get_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/metadata_controller.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class FollowBtn extends ConsumerWidget {
  const FollowBtn(this.profileUuid, this.isPrivateProfile, {super.key});

  final String profileUuid;
  final bool isPrivateProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var metadata = ref.watch(metadataControllerProvider(profileUuid)
        .select((v) => v.valueOrNull?.relationshipMetaData));

    var isAlreadyFollowing = metadata?.isAlreadyFollowing ?? false;
    var isAlreadyRequestedToFollow =
        metadata?.isAlreadyRequestedToFollow ?? false;

    var isFollowing = isAlreadyFollowing || isAlreadyRequestedToFollow;

    return MenuItem(
      color: isFollowing ? colorRed : null,
      label: getLabel(isAlreadyFollowing, isAlreadyRequestedToFollow),
      image: isFollowing ? Assets.images.giFollowing : Assets.images.giFollow,
      onTap: () => onTap(
        context,
        isFollowing,
        ref,
        isAlreadyFollowing,
        isAlreadyRequestedToFollow,
      ),
    );
  }

  String getLabel(bool isAlreadyFollowing, bool isAlreadyRequestedToFollow) {
    if (isAlreadyRequestedToFollow) return 'Requested';
    if (isAlreadyFollowing) return 'Following';
    if (isPrivateProfile) return 'Follow Request';
    return 'Follow';
  }

  Future<void> onTap(
    BuildContext context,
    bool isFollowing,
    WidgetRef ref,
    bool isAlreadyFollowing,
    bool isAlreadyRequestedToFollow,
  ) async {
    if (isFollowing) {
      await ref
          .read(getProfileControllerProvider(profileUuid).notifier)
          .unfollow();
    } else {
      await ref
          .read(getProfileControllerProvider(profileUuid).notifier)
          .follow();
    }

    ref.read(metadataControllerProvider(profileUuid).notifier).refresh();
  }
}
