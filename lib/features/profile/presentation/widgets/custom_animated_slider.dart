import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';

typedef ImageGetter = String? Function(int index);
typedef ChildBuilder = Widget? Function(int index);

class CustomAnimatedSlider<T> extends StatefulWidget {
  const CustomAnimatedSlider({
    super.key,
    required this.length,
    this.onChanged,
    required this.imageGetter,
    this.child,
    this.alignment,
    this.padding,
    this.viewportFraction = .335,
    this.initialPage = 1,
    this.isLoop = true,
    this.showIndicator = true,
    this.isMoved = true,
    this.onTap,
  });

  final int length;
  final ValueChanged<int>? onChanged;
  final ImageGetter imageGetter;

  final ChildBuilder? child;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final double viewportFraction;
  final int initialPage;
  final bool isLoop;
  final bool showIndicator;
  final bool isMoved;
  final ValueChanged<int>? onTap;

  @override
  State<CustomAnimatedSlider<T>> createState() =>
      _CustomAnimatedSliderState<T>();
}

class _CustomAnimatedSliderState<T> extends State<CustomAnimatedSlider<T>> {
  late int current;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    current = widget.initialPage;
    controller = PageController(
      initialPage: widget.initialPage,
      viewportFraction: widget.viewportFraction,
    );
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedSlider<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialPage != widget.initialPage) {
      current = widget.initialPage;
      controller = PageController(
        initialPage: widget.initialPage,
        viewportFraction: widget.viewportFraction,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: .3.sh,
          child: PageView.builder(
            padEnds: false,
            pageSnapping: true,
            itemCount: widget.isLoop ? null : widget.length,
            onPageChanged: !widget.isMoved
                ? null
                : (value) {
                    current = value;
                    setState(() {});

                    widget.onChanged?.call(current % widget.length);
                  },
            controller: controller,
            scrollDirection: Axis.horizontal,
            physics: widget.isMoved
                ? const PageScrollPhysics()
                : NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var isPrev = current < index;
              var isCenter = index.isOdd;

              var data = index % widget.length;

              return _SliderItem(
                data: data,
                index: index,
                isPrev: isPrev,
                current: current,
                isCenter: isCenter,
                child: widget.child,
                onTap: widget.onTap,
                controller: controller,
                padding: widget.padding,
                isMoved: widget.isMoved,
                alignment: widget.alignment,
                imageGetter: widget.imageGetter,
              );
            },
          ),
        ),
        if (widget.showIndicator)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 10,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.length,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(width: 4),
                itemBuilder: (context, index) {
                  var isSelected = (current % widget.length) == index;

                  return Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !isSelected ? null : colorRed,
                      border:
                          isSelected ? null : Border.all(color: colorTextGrey),
                    ),
                  );
                },
              ),
            ),
          )
      ],
    );
  }
}

class _SliderItem extends StatelessWidget {
  const _SliderItem({
    required this.current,
    required this.controller,
    required this.isCenter,
    required this.isPrev,
    required this.isMoved,
    required this.data,
    required this.onTap,
    required this.index,
    required this.imageGetter,
    required this.padding,
    required this.alignment,
    required this.child,
  });

  final int data;
  final int index;
  final int current;
  final bool isPrev;
  final bool isMoved;
  final bool isCenter;
  final ChildBuilder? child;
  final ImageGetter imageGetter;
  final ValueChanged<int>? onTap;
  final PageController controller;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    double top = isCenter
        ? 40
        : isPrev
            ? 0
            : 20;

    return GestureDetector(
      onTap: () {
        if (!isMoved) {
          onTap?.call(index);
          return;
        }

        if (current != index) {
          controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
          );
        }
      },
      child: Opacity(
        opacity: isCenter || !isMoved ? 1 : .3,
        child: Stack(
          children: [
            AnimatedPositioned(
              top: top,
              duration: const Duration(milliseconds: 100),
              child: Center(
                child: Container(
                  height: .25.sh,
                  width: .32.sw,
                  decoration: BoxDecoration(
                    color: Color(0xff1D1D1D),
                    borderRadius: BorderRadius.circular(8),
                    image: imageGetter(data) == null
                        ? null
                        : DecorationImage(
                            image: CachedNetworkImageProvider(
                              imageGetter(data)!,
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                  padding: padding,
                  alignment: alignment,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: isCenter || !isMoved ? child?.call(data) : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
