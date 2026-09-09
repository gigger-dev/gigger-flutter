import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/giglist/providers/giglist_metadata_controller.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';

class GiglistLikeBtn extends ConsumerWidget {
  const GiglistLikeBtn({
    super.key,
    required this.uuid,
    required this.gigListUuid,
  });

  final String uuid;
  final String gigListUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(gigListMetadataControllerProvider(
      gigListUuid: gigListUuid,
      viewerUuid: uuid,
    ));

    var metadata = state.whenData((v) => v).valueOrNull;

    if (metadata == null) return SizedBox();

    return MenuItem(
      icon: metadata.hasAlreadyLiked
          ? CupertinoIcons.heart_fill
          : CupertinoIcons.heart,
      color: metadata.hasAlreadyLiked ? colorRed : colorWhite,
      label: '${metadata.likeCount}',
      onTap: () => onTap(ref),
    );
  }

  void onTap(WidgetRef ref) {
    var controller = ref.read(gigListMetadataControllerProvider(
      gigListUuid: gigListUuid,
      viewerUuid: uuid,
    ).notifier);

    controller.toggleLike();
  }
}
