import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/video_player/providers/video_controller.dart';

import 'package:mobile_gigger_app/widgets/popup_btn.dart';
import 'package:popover/popover.dart';

class VideoActionBtn extends ConsumerWidget {
  const VideoActionBtn({
    super.key,
    required this.isFromOwn,
    required this.onEditContent,
    required this.onDeleteContent,
    required this.onCreateSup,
    required this.onShareTap,
    required this.onCopyLinkTap,
    required this.onSendDmTap,
  });

  final bool isFromOwn;
  final VoidCallback onShareTap;
  final VoidCallback onSendDmTap;
  final VoidCallback onCreateSup;
  final VoidCallback onCopyLinkTap;
  final VoidCallback onEditContent;
  final VoidCallback onDeleteContent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupBtn(
      width: .5.sw,
      direction: PopoverDirection.bottom,
      onShow: () {
        ref.read(videoControllerProvider.notifier).showingAction(true);
      },
      onPop: () {
        if (!context.mounted) return;
        ref.read(videoControllerProvider.notifier).showingAction(false);
      },
      items: isFromOwn
          ? [
              PopupItem(
                title: 'Report a problem',
                onTap: () => SheetUtils.newComingSoonSheet(context),
              ),
              PopupItem(title: 'Share this content', onTap: onShareTap),
              PopupItem(title: 'Copy content link', onTap: onCopyLinkTap),
              PopupItem(title: 'Edit content', onTap: onEditContent),
              PopupItem(title: 'Delete content', onTap: onDeleteContent),
              PopupItem(title: "Create a S'Up for this", onTap: onCreateSup),
            ]
          : [
              PopupItem(title: 'Send DM', onTap: onSendDmTap),
              PopupItem(title: 'Share it', onTap: onShareTap),
              PopupItem(
                title: 'Support user',
                onTap: () => SheetUtils.newComingSoonSheet(context),
              ),
              PopupItem(
                title: 'Report a problem',
                onTap: () => SheetUtils.newComingSoonSheet(context),
              ),
            ],
    );
  }
}
