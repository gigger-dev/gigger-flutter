import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/video_player/providers/video_metadata_controller.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';
import 'package:mobile_gigger_app/models/post_metadata.dart';

class VideoLikeBtn extends ConsumerWidget {
  final String postUuid;
  final PostMetadata? metadata;

  const VideoLikeBtn({
    super.key,
    required this.postUuid,
    required this.metadata,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewerUuid = ref.watch(profileControllerProvider).value!.uuid;

    return MenuItem(
      icon: metadata?.hasAlreadyLiked ?? false
          ? CupertinoIcons.heart_fill
          : CupertinoIcons.heart,
      color: metadata?.hasAlreadyLiked ?? false ? colorRed : colorWhite,
      label: '${metadata?.likeCount ?? 0}',
      onTap: () => onTap(ref, viewerUuid),
    );
  }

  void onTap(WidgetRef ref, String viewerUuid) {
    var controller = ref.read(videoMetadataControllerProvider(
      postUuid: postUuid,
      viewerUuid: viewerUuid,
    ).notifier);

    controller.toggleLike();
  }
}
