import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    super.key,
    required this.title,
    required this.children,
    this.padding,
  });

  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: colorWhite),
        title: TextViewWidget(text: title, textSize: 16),
      ),
      body: ListView(
        padding: padding ?? const EdgeInsets.all(10),
        children: children,
      ),
    );
  }
}
