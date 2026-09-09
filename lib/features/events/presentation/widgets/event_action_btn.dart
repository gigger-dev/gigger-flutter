import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';

import 'package:mobile_gigger_app/widgets/popup_btn.dart';
import 'package:popover/popover.dart';

class EventActionBtn extends StatelessWidget {
  const EventActionBtn({
    super.key,
    required this.isFromOwn,
    required this.isLineUp,
    required this.onEditContent,
    required this.onDeleteContent,
    required this.onCreateSup,
    required this.onAddReminder,
    required this.onShareTap,
    required this.onAcceptTap,
    required this.onRejectTap,
  });

  final bool isFromOwn;
  final bool isLineUp;
  final VoidCallback onEditContent;
  final VoidCallback onDeleteContent;
  final VoidCallback onCreateSup;
  final VoidCallback onAddReminder;
  final VoidCallback onShareTap;
  final VoidCallback onAcceptTap;
  final VoidCallback onRejectTap;

  @override
  Widget build(BuildContext context) {
    var items = <PopupItem>[];

    if (isFromOwn) {
      items = [
        PopupItem(
          title: 'Boost it!',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        PopupItem(title: 'Modify event', onTap: onEditContent),
        PopupItem(title: 'Delete event', onTap: onDeleteContent),
        PopupItem(title: 'Share this content', onTap: onShareTap),
        PopupItem(title: "Create a S'Up for this", onTap: onCreateSup),
      ];
    } else {
      items = [
        PopupItem(title: 'Add reminder', onTap: onAddReminder),
        PopupItem(
          title: 'Report a problem',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        PopupItem(title: 'Share this content', onTap: onShareTap),
      ];

      if (isLineUp) {
        items = [
          PopupItem(title: 'Accept', onTap: onAcceptTap),
          PopupItem(title: 'Reject', onTap: onRejectTap),
          PopupItem(title: 'Share this content', onTap: onShareTap),
          ...items,
        ];
      }
    }

    return PopupBtn(
      width: .5.sw,
      direction: PopoverDirection.bottom,
      icon: const Icon(
        Icons.more_horiz,
        color: Colors.white,
        size: 30,
        shadows: [BoxShadow(blurRadius: 10)],
      ),
      items: items,
    );
  }
}
