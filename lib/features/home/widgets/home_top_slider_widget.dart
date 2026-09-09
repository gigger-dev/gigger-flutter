import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/main/providers/main_controller.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class HomeTopSliderWidget extends ConsumerStatefulWidget {
  const HomeTopSliderWidget({
    super.key,
    required this.profile,
  });

  final ProfileOut profile;

  @override
  ConsumerState<HomeTopSliderWidget> createState() =>
      _HomeTopSliderWidgetState();
}

class _HomeTopSliderWidgetState extends ConsumerState<HomeTopSliderWidget> {
  ValueNotifier scale = ValueNotifier(1.0);
  late List<Widget> children;

  @override
  void initState() {
    super.initState();
    children = [_ProfileInfo(widget.profile)];

    // if (widget.user.isPro) {
    //   children.addAll([
    //     const _AppointmentWidget(),
    //     const _InsightWidget(),
    //     const _MessageWidget(),
    //   ]);
    // }
  }

  @override
  Widget build(BuildContext context) {
    var index = ref.watch(mainControllerProvider).homeSlideIndex;

    return CarouselSlider.builder(
      itemCount: children.length,
      options: CarouselOptions(
        padEnds: false,
        height: .5.sh,
        initialPage: index,
        disableCenter: true,
        onScrolled: _onScrolled,
        pauseAutoPlayOnTouch: true,
        enableInfiniteScroll: false,
        onPageChanged: _onPageChanged,
        viewportFraction: index == 1 ? .9 : 1,
        // autoPlay: index == 0 && widget.user.isPro,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 4),
      ),
      itemBuilder: (context, index, realIndex) {
        if (index == 0) {
          return AnimatedBuilder(
            animation: scale,
            builder: (context, child) {
              return Opacity(
                opacity: scale.value,
                child: Transform.scale(
                  scale: scale.value,
                  alignment: Alignment.centerLeft,
                  child: children[index],
                ),
              );
            },
          );
        }
        return children[index];
      },
    );
  }

  void _onScrolled(double? value) {
    var d = value?.toStringAsFixed(2) ?? '';
    var digit = d.split('.').lastOrNull ?? '10';
    scale.value = 1 - (digit == '0.00' ? 0.0 : double.parse('0.$digit'));
    setState(() {});
  }

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    ref.read(mainControllerProvider.notifier).homeSlideIndex(index);
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo(this.profile);

  final ProfileOut profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: .16.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextViewWidget(
            text: 'HI THERE,',
            height: .8,
            textSize: 32,
            color: colorWhite,
          ),
          const SizedBox(height: 2),
          TextViewWidget(
            text: profile.account.username,
            height: 1,
            textSize: 32,
            color: colorOrangeRed,
          ),
          const TextViewWidget(
            text: 'Glad to see you back!',
            textSize: 14,
          ),
        ],
      ),
    );
  }
}

class _AppointmentWidget extends ConsumerStatefulWidget {
  const _AppointmentWidget();

  @override
  ConsumerState<_AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends ConsumerState<_AppointmentWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  int? current;
  late Timer timer;
  List appointments = [];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );

    controller.addListener(() => setState(() {}));

    fade();
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  void fade() {
    timer = Timer.periodic(const Duration(seconds: 6), (timer) async {
      if (current == null || !mounted) return;

      await controller.forward();

      await Future.delayed(const Duration(seconds: 1));

      current = current! + 1;
      if (current! >= appointments.length) {
        current = 0;
      }

      if (!mounted) return;

      setState(() {});

      if (controller.isCompleted) {
        await controller.reverse();
      } else {
        await controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var provider = ref.watch(appointmentProvider);
    // appointments = provider.whenData((v) => v).value ?? [];

    if (appointments.isNotEmpty) {
      current ??= 0;
    }

    var data = current == null ? null : appointments.elementAtOrNull(current!);

    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: .16.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data != null)
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: Tween<double>(begin: 1, end: 0).evaluate(controller),
              child: CupertinoButton(
                key: ValueKey(current),
                minSize: 0,
                padding: EdgeInsets.zero,
                onPressed: controller.isAnimating
                    ? null
                    : () {
                        log('onPressed');
                      },
                child: Row(
                  children: [
                    SizedBox(
                      width: .5.sw,
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 26.sp,
                            height: 1,
                            color: colorWhite,
                          ),
                          children: [
                            TextSpan(text: '${data.action} '),
                            TextSpan(
                              text: data.to,
                              style: const TextStyle(color: colorTextRed),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Icon(
                          CupertinoIcons.circle,
                          color: colorWhite,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: const TextViewWidget(
                text: 'Check all your appointments',
                textSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightWidget extends StatelessWidget {
  const _InsightWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: .12.sh),
      child: Column(
        children: [
          Container(
            height: .26.sh,
            width: 1.sw,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(Assets.images.insightChart.path),
              ),
            ),
            padding: EdgeInsets.only(left: 40.w, top: 18),
            child: const TextViewWidget(text: 'INSIGHTS', textSize: 26),
          ),
        ],
      ),
    );
  }
}

class _MessageWidget extends StatelessWidget {
  const _MessageWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: .14.sh, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextViewWidget(text: 'MESSAGES', textSize: 26),
          TextViewWidget(
            height: 1,
            text: '3 notifications',
            color: Colors.grey.shade700,
            textSize: 12,
          ),
          ListView.separated(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return const Row(
                children: [
                  CircleAvatar(radius: 16, backgroundColor: colorRed),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextViewWidget(text: 'Username 123'),
                        TextViewWidget(
                          text: 'Message preview Lorem ipsum what a won….',
                          textSize: 12,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      TextViewWidget(text: '3h', textSize: 12),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
