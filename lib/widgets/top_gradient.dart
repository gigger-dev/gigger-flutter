import 'package:flutter/material.dart';

class TopGradient extends StatelessWidget {
  const TopGradient({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [.1, 1],
            colors: [
              Colors.black38,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
