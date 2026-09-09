import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ConnectionTab extends StatelessWidget {
  const ConnectionTab(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: TextViewWidget(
        text: text,
        color: color,
        textAlign: TextAlign.center,
      ),
    );
  }
}
