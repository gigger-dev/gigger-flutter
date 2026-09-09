import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/home/providers/event_metadata_controller.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_sheet.dart';

class EventLikeBtn extends ConsumerWidget {
  const EventLikeBtn({
    super.key,
    required this.viewerUuid,
    required this.eventUuid,
  });

  final String eventUuid;
  final String viewerUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var metadata = ref
        .watch(eventMetadataControllerProvider(
          eventUuid: eventUuid,
          viewerUuid: viewerUuid,
        ))
        .valueOrNull;

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
    var controller = ref.watch(eventMetadataControllerProvider(
      eventUuid: eventUuid,
      viewerUuid: viewerUuid,
    ).notifier);

    controller.toggleLike();
  }
}
