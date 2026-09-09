import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';

class ProfileSlider extends StatefulWidget {
  const ProfileSlider({
    super.key,
    required this.users,
    required this.cdnUrl,
    required this.onChanged,
  });

  final String? cdnUrl;
  final List<ProfileOut> users;
  final ValueChanged<int> onChanged;

  @override
  State<ProfileSlider> createState() => _ProfileSliderState();
}

class _ProfileSliderState extends State<ProfileSlider> {
  int current = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: .335);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: .3.sh,
          child: PageView.builder(
            pageSnapping: true,
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.users.length + 1,
            onPageChanged: (value) {
              widget.onChanged(value);

              current = value;
              setState(() {});
            },
            itemBuilder: (context, index) {
              var isPrev = current > index;
              var isCenter = current == index;

              return _SliderItem(
                isPrev: isPrev,
                isCenter: isCenter,
                cdnUrl: widget.cdnUrl,
                user: widget.users.elementAtOrNull(index),
                onTap: () {
                  if (current != index) {
                    controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  }
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 10,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.users.length + 1,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(width: 4),
              itemBuilder: (context, index) {
                var isSelected = current == index;

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

class _SliderItem extends ConsumerWidget {
  const _SliderItem({
    required this.isPrev,
    required this.isCenter,
    required this.user,
    required this.onTap,
    required this.cdnUrl,
  });

  final bool isPrev;
  final ProfileOut? user;
  final bool isCenter;
  final String? cdnUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double top = isCenter
        ? 40
        : isPrev
            ? 20
            : 0;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedPositioned(
            top: top,
            duration: const Duration(milliseconds: 100),
            child: Center(
              child: Container(
                width: .32.sw,
                height: .25.sh,
                decoration: BoxDecoration(
                  color: Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(8),
                  image: user == null
                      ? null
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            '$cdnUrl/${user!.coverMedia}',
                          ),
                        ),
                ),
                child: user != null ? null : Center(child: Icon(Icons.add)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
