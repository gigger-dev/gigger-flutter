import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/popover_item.dart';
import 'package:popover/popover.dart';

class DraftActionBtn extends StatelessWidget {
  const DraftActionBtn({
    super.key,
    required this.onModifyTap,
    required this.onDeleteTap,
    required this.index,
  });

  final int index;
  final VoidCallback onModifyTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showPopover(
        width: 100,
        radius: 10,
        context: context,
        backgroundColor: colorTextRed,
        direction: PopoverDirection.bottom,
        bodyBuilder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopoverItem(title: 'Modify', onTap: onModifyTap),
              PopoverItem(title: 'Delete', onTap: onDeleteTap),
            ],
          ),
        ),
      ),
      icon: Icon(Icons.more_vert, color: colorWhite),
    );
  }
}
