import 'package:flutter/cupertino.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/main/widgets/menu_dialog.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:popover/popover.dart';

class AddItem extends StatelessWidget {
  const AddItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      onPressed: () => onTap(context),
      child: Image.asset(
        Assets.images.giAddDot.path,
        height: 28,
      ),
    );
  }

  Future<void> onTap(BuildContext context) async {
    await showPopover(
      width: 200,
      radius: 20,
      height: 390,
      arrowWidth: 28,
      arrowHeight: 17,
      context: context,
      backgroundColor: colorTextRed,
      direction: PopoverDirection.top,
      bodyBuilder: (context) => const MenuDialog(),
    );
  }
}
