import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class MenuComponent extends StatelessWidget {
  const MenuComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      iconColor: Colors.white,
      icon: const Icon(Icons.more_horiz),
      position: PopupMenuPosition.under,
      color: colorRed,
      itemBuilder: (context) => [
        item(title: 'Report a problem'),
        item(title: 'Privacy Settings'),
        item(title: 'Go to manage events'),
      ],
    );
  }

  PopupMenuItem<void> item({
    required String title,
  }) {
    return PopupMenuItem<void>(
      child: Text(
        title,
        style: const TextStyle(fontSize: 12, color: colorWhite),
      ),
      onTap: () {},
    );
  }
}
