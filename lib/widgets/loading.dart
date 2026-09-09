import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class Loading {
  OverlayEntry? overlayEntry;

  void show(BuildContext context) {
    hide();

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned.fill(
        child: Container(
          color: colorBlack.withOpacity(.5),
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: colorRed,
              ),
              padding: const EdgeInsets.all(6),
              child: Transform.scale(
                scale: .6,
                child: const CircularProgressIndicator(color: colorWhite),
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context).insert(overlayEntry!);
  }

  void hide() {
    try {
      overlayEntry?.remove();
    } catch (_) {}
  }
}

class OverlayLoading extends StatelessWidget {
  const OverlayLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: colorBlack.withOpacity(.5),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: colorRed,
            ),
            padding: const EdgeInsets.all(6),
            child: Transform.scale(
              scale: .6,
              child: const CircularProgressIndicator(color: colorWhite),
            ),
          ),
        ),
      ),
    );
  }
}
