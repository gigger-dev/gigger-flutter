import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:popover/popover.dart';

class PopupItem {
  final String title;
  final VoidCallback onTap;

  PopupItem({required this.title, required this.onTap});
}

class PopupBtn extends StatelessWidget {
  const PopupBtn({
    super.key,
    this.width = 100,
    this.direction = PopoverDirection.left,
    required this.items,
    this.icon,
    this.onPop,
    this.onShow,
    this.popOnTap = true,
  });

  final double width;
  final Widget? icon;
  final PopoverDirection direction;
  final List<PopupItem> items;
  final VoidCallback? onShow;
  final VoidCallback? onPop;
  final bool popOnTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onShow?.call();

        showPopover(
          context: context,
          backgroundColor: colorRed,
          direction: direction,
          onPop: onPop,
          width: width,
          bodyBuilder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: items.map((e) {
                return InkWell(
                  onTap: () {
                    if (popOnTap) context.pop();
                    e.onTap();
                  },
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: TextViewWidget(text: e.title, textSize: 14.sp),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
      icon: icon ?? Icon(Icons.more_vert),
    );
  }
}
