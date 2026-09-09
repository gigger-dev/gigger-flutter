import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:popover/popover.dart';

class BlockedAccountScreen extends StatefulWidget {
  const BlockedAccountScreen({super.key});

  @override
  State<BlockedAccountScreen> createState() => _BlockedAccountScreenState();
}

class _BlockedAccountScreenState extends State<BlockedAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Blocked accounts',
      children: [
        const SettingItem(
          title: 'Manage blocked accounts',
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: .5.sh,
          child: Center(
            child: TextViewWidget(
              text: 'EMPTY',
              color: colorTextGrey,
            ),
          ),
        )
        // ListView.builder(
        //   itemCount: 3,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return const ListTile(
        //       dense: true,
        //       contentPadding: EdgeInsets.only(left: 10),
        //       leading: CircleAvatar(
        //         radius: 20,
        //         backgroundColor: colorRed,
        //       ),
        //       title: TextViewWidget(text: 'Bellmio'),
        //       subtitle: TextViewWidget(
        //         text: 'Verona, Ita - Composer @Bellomio',
        //         textSize: 12,
        //       ),
        //       trailing: _ItemAction(),
        //     );
        //   },
        // )
      ],
    );
  }
}

class _ItemAction extends StatelessWidget {
  const _ItemAction();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onMenuTap(context),
      icon: const Icon(Icons.more_vert, color: colorWhite, size: 26),
    );
  }

  void onMenuTap(BuildContext context) {
    showPopover(
      context: context,
      onPop: () {},
      radius: 10,
      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 140),
      direction: PopoverDirection.left,
      backgroundColor: colorTextRed,
      bodyBuilder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(7),
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: TextViewWidget(text: 'Restore account'),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(7),
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: TextViewWidget(text: 'Report account'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
