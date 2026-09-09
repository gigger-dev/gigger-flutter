import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/six_grid.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/three_grid.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CpCm extends StatelessWidget {
  const CpCm({
    super.key,
    required this.isLast,
    required this.customPhrase,
    required this.closingMessage,
  });

  final bool isLast;
  final String? customPhrase;
  final String? closingMessage;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isLast ? 1 : .2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SixGrid(),
          ),
          if (customPhrase?.isNotEmpty ?? false)
            TextViewWidget(
              text: '"$customPhrase"',
              textSize: 30,
              color: colorWhite,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ThreeGrid(),
          ),
          if (closingMessage?.isNotEmpty ?? false)
            TextViewWidget(
              text: '"$closingMessage"',
              textSize: 30,
              color: colorWhite,
            ),
        ],
      ),
    );
  }
}
