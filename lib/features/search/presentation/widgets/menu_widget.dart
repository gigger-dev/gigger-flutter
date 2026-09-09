import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/search_widget.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key, required this.onMenuTap});

  final ValueChanged<int> onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 1.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(Assets.images.giAlenaDarmel.path),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: .5.sh,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorTransparent,
                  Color.fromRGBO(0, 0, 0, 0.93),
                  colorBlack,
                ],
                stops: [0, .8, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorBlack,
                  Color.fromRGBO(0, 0, 0, 0.93),
                  colorTransparent,
                ],
                stops: [0, .4, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextViewWidget(
                        text: 'DISCOVER',
                        textSize: 30,
                        height: 1,
                      ),
                      const TextViewWidget(
                        text: 'GIGGER\'S WORLD',
                        textSize: 30,
                        height: 1,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: .7.sw,
                        child: const TextViewWidget(
                          text: 'What are you looking for today?',
                          textSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    menuItem(index: 1, title: 'GIGGERS'),
                    menuItem(index: 2, title: 'VIDEOS'),
                    menuItem(index: 3, title: 'EVENTS'),
                    menuItem(index: 4, title: 'PRO SERVICES'),
                    menuItem(index: 5, title: 'CAMPAIGNS'),
                    menuItem(index: 6, title: 'MEMBERSHIPS'),
                    menuItem(index: 7, title: 'GIGLIST'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 45,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Assets.images.giRedGigger.path,
                  width: 70.w,
                ),
                Image.asset(
                  Assets.images.giMenu.path,
                  fit: BoxFit.cover,
                  color: colorWhite,
                  width: 18,
                )
              ],
            ),
          ),
        ),
        const SearchWidget(),
      ],
    );
  }

  Widget menuItem({required String title, required int index}) {
    return ListTile(
      dense: true,
      onTap: () => onMenuTap(index),
      title: TextViewWidget(text: title),
      contentPadding: const EdgeInsets.only(left: 30),
      trailing: const Icon(CupertinoIcons.right_chevron, color: colorWhite),
    );
  }
}
