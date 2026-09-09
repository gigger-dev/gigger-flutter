import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CountWidget extends StatelessWidget {
  const CountWidget({
    super.key,
    required this.viewCount,
    required this.followersCount,
    required this.likeCount,
    required this.uuid,
    required this.isVisitor,
    required this.profileUuid,
  });

  final int viewCount;
  final int followersCount;
  final int likeCount;
  final String uuid;
  final String profileUuid;
  final bool isVisitor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 8),
                TextViewWidget(text: '$viewCount', textSize: 14.sp),
                TextViewWidget(
                  text: 'View${viewCount > 1 ? 's' : ''}',
                  height: 2,
                  textSize: 13.sp,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: isVisitor ? null : () => ConnectionRoute().push(context),
            icon: Column(
              children: [
                TextViewWidget(text: '$followersCount', textSize: 14.sp),
                TextViewWidget(
                  text: 'Follower${followersCount > 1 ? 's' : ''}',
                  height: 2,
                  textSize: 13.sp,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 6),
                TextViewWidget(text: '$likeCount', textSize: 14.sp),
                SizedBox(height: 2),
                Icon(CupertinoIcons.heart, size: 20, color: colorWhite),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
