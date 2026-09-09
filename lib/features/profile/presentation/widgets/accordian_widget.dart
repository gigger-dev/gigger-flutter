import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';

class AccordionWidget extends StatefulWidget {
  final String title;
  final List<Widget> content;
  final TextStyle? titleStyle;
  final bool initiallyExpanded;

  const AccordionWidget({
    super.key,
    required this.title,
    required this.content,
    this.titleStyle,
    this.initiallyExpanded = false,
  });
  @override
  State<AccordionWidget> createState() => _AccordionWidgetState();
}

class _AccordionWidgetState extends State<AccordionWidget> {
  // Show or hide the content
  bool _showContent = false;
  int showItemCount = 3;

  @override
  void initState() {
    super.initState();
    _showContent = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          // The title
          InkWell(
            onTap: () {
              setState(() {
                _showContent = !_showContent;
                if (!_showContent) {
                  showItemCount = 3;
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: widget.titleStyle ??
                          TextStyle(color: colorWhite, fontSize: 16.sp),
                    ),
                  ),
                  Icon(
                    _showContent ? Icons.expand_less : Icons.expand_more,
                    color: colorWhite,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    return SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: animation,
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: _showContent
                      ? Padding(
                          key: ValueKey(_showContent),
                          padding: EdgeInsets.only(top: 15.h),
                          child: Column(
                            children:
                                widget.content.take(showItemCount).toList(),
                          ),
                        )
                      : SizedBox(key: ValueKey(_showContent)),
                ),
                if (widget.content.length > showItemCount)
                  if (_showContent && showItemCount == 3)
                    InkWell(
                      onTap: () {
                        setState(() {
                          showItemCount = widget.content.length;
                        });
                      },
                      child: const Text(
                        'Show all',
                        style: TextStyle(
                          color: colorTextRed,
                        ),
                      ),
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
