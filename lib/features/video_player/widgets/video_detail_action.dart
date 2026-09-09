import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/metadata_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/video_player/providers/video_metadata_controller.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/follow_btn.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_like_btn.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideoDetailAction extends ConsumerWidget {
  const VideoDetailAction({
    super.key,
    required this.isFromOwn,
    required this.postUuid,
    required this.onShareTap,
    required this.profileUuid,
    required this.isPrivateProfile,
  });

  final bool isFromOwn;
  final String postUuid;
  final String profileUuid;
  final bool isPrivateProfile;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewerUuid = ref.watch(profileControllerProvider).value!.uuid;
    var metadata = ref
        .watch(videoMetadataControllerProvider(
          postUuid: postUuid,
          viewerUuid: viewerUuid,
        ))
        .valueOrNull;

    var profileMetadata = ref.watch(metadataControllerProvider(profileUuid));

    return Skeletonizer(
      enabled: metadata == null || profileMetadata.valueOrNull == null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: isFromOwn
            ? Row(
                children: [
                  MenuItem(
                    label: 'Share',
                    onTap: onShareTap,
                    image: Assets.images.giShare,
                  ),
                  SizedBox(width: 32.w),
                  MenuItem(
                    label: 'Boost it!',
                    image: Assets.images.giBoost,
                    onTap: () => SheetUtils.newComingSoonSheet(context),
                  ),
                  SizedBox(width: 32.w),
                  MenuItem(
                    label: 'Insights',
                    image: Assets.images.giInsights,
                    onTap: () => SheetUtils.newComingSoonSheet(context),
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    children: [
                      MenuItem(
                        label: 'Support',
                        image: Assets.images.giSupport,
                        onTap: () => SheetUtils.newComingSoonSheet(context),
                      ),
                      SizedBox(width: 32.w),
                      MenuItem(
                        label: 'Message',
                        image: Assets.images.giMessage,
                        onTap: () => ChatRoute(uuid: profileUuid).push(context),
                      ),
                      SizedBox(width: 32.w),
                      VideoLikeBtn(metadata: metadata, postUuid: postUuid),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      MenuItem(
                        label: 'Share',
                        onTap: onShareTap,
                        image: Assets.images.giShare,
                      ),
                      SizedBox(width: 32.w),
                      FollowBtn(profileUuid, isPrivateProfile),
                      SizedBox(width: 32.w),
                      MenuItem(
                        label: 'Calendar',
                        image: Assets.images.giCalendar,
                        onTap: () => SheetUtils.newComingSoonSheet(context),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
