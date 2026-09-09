import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScrollbar extends StatelessWidget {
  const ProfileScrollbar({
    super.key,
    required this.offset,
    required this.isCoverEdit,
    required this.controller,
    required this.children,
  });

  final double offset;
  final bool isCoverEdit;
  final List<Widget> children;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: isCoverEdit ? .48.sh : 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.black38,
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [
              .22 + (offset / 700),
              .4 + (offset / 600),
              .6 + (offset / 500),
            ],
          ),
        ),
        child: ListView(
          controller: controller,
          physics: isCoverEdit ? const NeverScrollableScrollPhysics() : null,
          padding: const EdgeInsets.only(bottom: 50),
          children: children,
        ),
      ),
    );
  }
}
