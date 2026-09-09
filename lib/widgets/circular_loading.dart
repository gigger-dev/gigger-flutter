import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key, this.scale = .8, this.height});

  final double scale;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Transform.scale(
          scale: scale,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
