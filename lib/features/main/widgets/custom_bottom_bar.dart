import 'package:flutter/material.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.items,
  });

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: colorBlack,
      child: Row(
        children: [
          const Expanded(flex: 2, child: SizedBox()),
          ...items,
        ],
      ),
    );
  }
}

class BottomItem extends StatelessWidget {
  const BottomItem({
    super.key,
    required this.onTap,
    required this.icon,
    this.onLongPress,
    this.useColor = true,
    required this.isSelected,
    this.identifier,
  });

  final dynamic icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool useColor;
  final String? identifier;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (icon is Widget) {
      child = icon;
    } else if (icon is IconData) {
      child = Icon(
        icon,
        color: !isSelected ? colorGreyLight : colorWhite,
        size: 28,
      );
    } else {
      child = Image.asset(
        (icon as AssetGenImage).path,
        color: useColor ? colorWhite : null,
        height: 28,
      );
    }

    return Expanded(
      child: Semantics(
        identifier: identifier,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: child,
        ),
      ),
    );
  }
}
