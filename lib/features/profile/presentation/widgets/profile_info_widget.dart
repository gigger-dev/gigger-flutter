import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/location_in.dart';
import 'package:mobile_gigger_app/models/location_out.dart';
import 'package:mobile_gigger_app/models/skill_out.dart';
import 'package:mobile_gigger_app/widgets/circular_image_widget.dart';
import 'package:mobile_gigger_app/widgets/show_image_viewer.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    super.key,
    required this.isEditMode,
    required this.isVisitor,
    required this.avatarMedia,
    required this.username,
    required this.location,
    required this.skills,
    required this.onFollowTap,
    required this.isPrivateProfile,
    required this.isAlreadyRequestedToFollow,
    required this.isAlreadyFollowing,
    required this.onUnFollowTap,
  });

  final bool isEditMode;
  final bool isVisitor;
  final bool isAlreadyRequestedToFollow;
  final bool isPrivateProfile;
  final bool isAlreadyFollowing;
  final String avatarMedia;
  final String username;
  final LocationIn location;
  final List<SkillOut> skills;
  final VoidCallback onFollowTap;
  final VoidCallback onUnFollowTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: isEditMode
                  ? null
                  : () => showImageViewer(context, url: avatarMedia),
              child: Hero(
                tag: Key(avatarMedia),
                child: CircularImageWidget(imageUrl: avatarMedia, radius: 36),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextViewWidget(
                      text: username,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    if (skills.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: TextViewWidget(
                          text: skills.map((e) => e.name).join(', '),
                          textSize: 12,
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Icon(
                              size: 15,
                              Icons.location_on,
                              color: colorWhite,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: TextViewWidget(
                              text: locationFormat(location),
                              textSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isVisitor)
              FollowBtn(
                isAlreadyRequestedToFollow: isAlreadyRequestedToFollow,
                isAlreadyFollowing: isAlreadyFollowing,
                isPrivateProfile: isPrivateProfile,
                onUnFollowTap: onUnFollowTap,
                onFollowTap: onFollowTap,
              ),
          ],
        ),
      ),
    );
  }
}

String locationFormat(LocationIn l) {
  return '${l.address?.isNotEmpty ?? false ? '${l.address}, ' : ''}${l.city}, ${l.state}, ${l.country}';
}

String locationFormat2(LocationOut l) {
  return '${l.address?.isNotEmpty ?? false ? '${l.address}, ' : ''}${l.city}, ${l.state}, ${l.country}';
}

class FollowBtn extends StatelessWidget {
  const FollowBtn({
    super.key,
    this.minSize = kMinInteractiveDimensionCupertino,
    required this.onUnFollowTap,
    required this.onFollowTap,
    required this.isAlreadyRequestedToFollow,
    required this.isAlreadyFollowing,
    required this.isPrivateProfile,
  });

  final double? minSize;

  final bool isPrivateProfile;
  final bool isAlreadyFollowing;
  final bool isAlreadyRequestedToFollow;

  final VoidCallback onUnFollowTap;
  final VoidCallback onFollowTap;

  @override
  Widget build(BuildContext context) {
    var isFollowing = isAlreadyFollowing || isAlreadyRequestedToFollow;

    return CupertinoButton(
      minSize: minSize,
      onPressed: isFollowing ? onUnFollowTap : onFollowTap,
      child: Column(
        children: [
          Image.asset(
            isFollowing
                ? Assets.images.giFollowing.path
                : Assets.images.giFollow.path,
            height: 22,
            color: isFollowing ? colorRed : null,
          ),
          const SizedBox(height: 4),
          TextViewWidget(
            text: getLabel(),
            textSize: 12,
          ),
        ],
      ),
    );
  }

  String getLabel() {
    if (isAlreadyRequestedToFollow) return 'Requested';
    if (isAlreadyFollowing) return 'Following';
    if (isPrivateProfile) return 'Follow Request';
    return 'Follow';
  }
}
