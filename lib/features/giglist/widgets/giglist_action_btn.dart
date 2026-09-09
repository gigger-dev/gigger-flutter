import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';

import 'package:mobile_gigger_app/widgets/popup_btn.dart';
import 'package:popover/popover.dart';

class GiglistActionBtn extends StatelessWidget {
  const GiglistActionBtn({
    super.key,
    required this.isFromOwn,
    required this.onEditContent,
    required this.onDeleteContent,
    required this.onCreateSup,
  });

  final bool isFromOwn;
  final VoidCallback onEditContent;
  final VoidCallback onDeleteContent;
  final VoidCallback onCreateSup;

  @override
  Widget build(BuildContext context) {
    return PopupBtn(
      width: .5.sw,
      direction: PopoverDirection.bottom,
      icon: const Icon(
        Icons.more_horiz,
        color: Colors.white,
        size: 30,
        shadows: [BoxShadow(blurRadius: 10)],
      ),
      items: !isFromOwn
          ? [
              PopupItem(
                title: 'Report a problem',
                onTap: () => SheetUtils.newComingSoonSheet(context),
              ),
            ]
          : [
              PopupItem(
                title: 'Boost it!',
                onTap: () => SheetUtils.newComingSoonSheet(context),
              ),
              PopupItem(title: 'Modify this announ.', onTap: onEditContent),
              PopupItem(title: 'Delete Giglist', onTap: onDeleteContent),
              PopupItem(title: "Create a S'Up for this", onTap: onCreateSup),
            ],
    );
  }
}
