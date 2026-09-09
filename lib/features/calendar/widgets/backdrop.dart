import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class Backdrop extends StatelessWidget {
  const Backdrop({
    required this.back,
    required this.front,
    required this.onTodayTap,
    required this.selectedDate,
    required this.controller,
    super.key,
    this.isShowToday = false,
  });

  final Widget back;
  final Widget front;
  final bool isShowToday;
  final VoidCallback onTodayTap;
  final DateTime selectedDate;
  final DraggableScrollableController controller;

  @override
  Widget build(BuildContext context) {
    const themeColor = Colors.deepOrange;

    return Stack(
      children: [
        back,
        DraggableScrollableSheet(
          snap: true,
          minChildSize: 0,
          initialChildSize: 0,
          snapSizes: const [1],
          controller: controller,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [colorBlack1A, Colors.black],
                  stops: [0, .2],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Stack(
                children: [
                  ListView(
                    controller: scrollController,
                    padding: EdgeInsets.only(bottom: 20),
                    children: [
                      Center(
                        child: Container(
                          height: 2,
                          width: 80,
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          decoration: const BoxDecoration(color: Colors.grey),
                        ),
                      ),
                      front,
                    ],
                  ),
                  if (isShowToday)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CupertinoButton(
                        onPressed: onTodayTap,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: themeColor),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                '${DateTime.now().day}',
                                style: const TextStyle(
                                  color: themeColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Today',
                              style: TextStyle(color: themeColor, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
