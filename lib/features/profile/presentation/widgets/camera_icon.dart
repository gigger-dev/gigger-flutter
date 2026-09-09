import 'package:flutter/cupertino.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class CameraIcon extends StatelessWidget {
  const CameraIcon({
    super.key,
    this.size = 12,
    this.padding = 6,
    this.hasShadow = true,
  });

  final bool hasShadow;
  final double padding;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorGrey,
        shape: BoxShape.circle,
        boxShadow: !hasShadow
            ? null
            : [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(4, 4),
                ),
              ],
      ),
      padding: EdgeInsets.all(padding),
      child: Icon(
        CupertinoIcons.camera_fill,
        size: size,
        color: colorWhite,
      ),
    );
  }
}
