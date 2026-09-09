import 'package:flutter/material.dart';

class CustomRectangularSliderThumb extends SliderComponentShape {
  final double thumbRadius;
  final double thumbHeight;
  final Color thumbColor;
  final double borderRadius;

  CustomRectangularSliderThumb({
    required this.thumbRadius,
    required this.thumbHeight,
    required this.thumbColor,
    required this.borderRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint borderPaint = Paint()
      ..color = Colors.black // Border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.0; // Border width

    final Paint fillPaint = Paint()..color = thumbColor;

    final Rect thumbRect = Rect.fromPoints(
      Offset(center.dx - thumbRadius, center.dy - (thumbHeight / 2)),
      Offset(center.dx + thumbRadius, center.dy + (thumbHeight / 2)),
    );

    final RRect thumbRRect =
        RRect.fromRectAndRadius(thumbRect, Radius.circular(borderRadius));

    canvas.drawRRect(thumbRRect, borderPaint);
    canvas.drawRRect(thumbRRect, fillPaint);
  }
}
