import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScrollBar extends StatelessWidget {
  const ProfileScrollBar({
    super.key,
    required this.isCover,
    required this.isLast,
    required this.offset,
    required this.children,
    required this.controller,
  });

  final bool isCover;
  final bool isLast;
  final double offset;
  final List<Widget> children;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: isCover ? 0.55.sh : 0,
      child: ListView(
        controller: controller,
        physics: isLast ? null : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
        children: children,
      ),
    );
  }
}
