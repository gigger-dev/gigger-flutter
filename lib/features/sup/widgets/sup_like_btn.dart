import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/sup/providers/sup_metadata_controller.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';

class SupLikeBtn extends ConsumerWidget {
  const SupLikeBtn(this.uuid, {super.key});

  final String uuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewerUuid = ref.watch(profileControllerProvider).value!.uuid;
    var metadata = ref
        .watch(supMetadataControllerProvider(
          supUuid: uuid,
          viewerUuid: viewerUuid,
        ))
        .valueOrNull;

    var hasAlreadyLiked = metadata?.hasAlreadyLiked ?? false;
    var likeCount = metadata?.likeCount ?? 0;

    return MenuItem(
      label: '$likeCount',
      color: hasAlreadyLiked ? colorRed : colorWhite,
      icon: hasAlreadyLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
      onTap: () => onTap(ref, viewerUuid),
    );
  }

  void onTap(WidgetRef ref, String viewerUuid) {
    var controller = ref.read(supMetadataControllerProvider(
      supUuid: uuid,
      viewerUuid: viewerUuid,
    ).notifier);

    controller.toggleLike();
  }
}
