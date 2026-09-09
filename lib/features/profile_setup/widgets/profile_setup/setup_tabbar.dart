import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile_setup/profile_setup_screen.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

typedef TabBarTap = void Function(int index, int current);

class SetupTabBar extends StatelessWidget {
  const SetupTabBar({
    super.key,
    required this.controller,
    required this.onTap,
    required this.current,
  });

  final int current;
  final TabController controller;
  final TabBarTap onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BackButton(),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            color: colorBlack.withOpacity(.4),
            child: TabBar(
              dividerHeight: 0,
              isScrollable: true,
              controller: controller,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              onTap: (v) => onTap(v, current),
              indicatorPadding: EdgeInsets.zero,
              indicator: const BoxDecoration(),
              physics: const NeverScrollableScrollPhysics(),
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              tabs: [
                for (int i = 0; i < ProfileType.values.length; i++)
                  Tab(
                    child: Row(
                      children: [
                        TextViewWidget(
                          textSize: 16,
                          text: ProfileType.values[i].value,
                          color: i == current ? colorRed : Colors.grey.shade700,
                        ),
                        i == ProfileType.values.length - 1
                            ? const SizedBox(width: 40)
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14),
                                child: Icon(
                                  CupertinoIcons.right_chevron,
                                  color: Colors.grey.shade700,
                                  size: 30,
                                ),
                              ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
