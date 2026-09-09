import 'package:flutter/cupertino.dart';

class SlideSwitcher extends StatelessWidget {
  const SlideSwitcher({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => animation.isCompleted
          ? SlideTransition(
              position: Tween(begin: Offset(-1, 0), end: Offset(0, 0))
                  .animate(animation),
              child: child,
            )
          : SlideTransition(
              position: Tween(begin: Offset(1, 0), end: Offset(0, 0))
                  .animate(animation),
              child: child,
            ),
      child: child,
    );
  }
}
