import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/home/widgets/sup_widget.dart';

class SupBottom extends StatelessWidget {
  const SupBottom({super.key, required this.current, required this.hideSup});

  final int current;
  final bool hideSup;

  @override
  Widget build(BuildContext context) {
    var decoration = const BoxDecoration(
      gradient: LinearGradient(
        stops: [.2, 1],
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
        colors: [colorBlack, Colors.transparent],
      ),
    );

    return Align(
      alignment: Alignment.bottomLeft,
      child: IgnorePointer(
        ignoring: hideSup,
        child: Container(
          height: 100.h,
          width: 1.sw,
          decoration: decoration,
          child: AnimatedSwitcher(
            transitionBuilder: transitionBuilder,
            duration: const Duration(milliseconds: 400),
            child: hideSup
                ? SizedBox(key: Key('hide_$current'), height: 40.h, width: 1.sw)
                : SupWidget(key: Key('show_$current')),
          ),
        ),
      ),
    );
  }

  Widget transitionBuilder(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
          .animate(animation),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}
