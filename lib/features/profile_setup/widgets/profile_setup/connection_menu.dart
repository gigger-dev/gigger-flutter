import 'package:flutter/cupertino.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ConnectionMenu extends StatelessWidget {
  const ConnectionMenu({
    super.key,
    required this.isLast,
  });

  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isLast ? 1 : .2,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              TextViewWidget(text: '-'),
              TextViewWidget(text: 'Views'),
            ],
          ),
          Column(
            children: [
              TextViewWidget(text: '-'),
              TextViewWidget(text: 'Followers'),
            ],
          ),
          Column(
            children: [
              TextViewWidget(text: '-'),
              Icon(CupertinoIcons.heart_solid),
            ],
          ),
        ],
      ),
    );
  }
}
