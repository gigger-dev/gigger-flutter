import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/get_share_url.dart';
import 'package:mobile_gigger_app/features/video_player/widgets/video_detail_action.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/circular_image_widget.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:share_plus/share_plus.dart';

class VideoDetailSheet extends StatelessWidget {
  const VideoDetailSheet({
    super.key,
    required this.profile,
    required this.cdnUrl,
    required this.data,
    required this.isFromOwn,
  });

  final PostOut data;
  final String cdnUrl;
  final bool isFromOwn;
  final ProfileOut profile;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: .88.sh),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(height: 3, width: 100, color: colorGrey),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: GestureDetector(
                onTap: () => context.pop(true),
                child: Row(
                  children: [
                    CircularImageWidget(
                      imageUrl: '$cdnUrl/${profile.avatarMedia}',
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextViewWidget(
                            text: profile.account.username,
                            textSize: 16.sp,
                          ),
                          const SizedBox(height: 1),
                          TextViewWidget(
                            text: profile.skills.map((e) => e.name).join(', '),
                            textSize: 12.sp,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.white,
                        size: 40,
                        shadows: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 6,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.musicTitle.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Image.asset(
                            Assets.images.giMusic.path,
                            width: 12,
                            height: 12,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextViewWidget(text: data.musicTitle),
                        ),
                      ],
                    ),
                  if (data.location.isNotEmpty)
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 20),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextViewWidget(
                            text: data.location,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Container(
                                height: 10.h,
                                width: 10.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: profile.availabilityStatus
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              TextViewWidget(
                                text: profile.availabilityStatus
                                    ? 'Available!'
                                    : 'Unavailable',
                              ),
                              // SizedBox(width: 6.w),
                              // const TextViewWidget(
                              //   text: 'When?',
                              //   color: Color(0xffEE4A30),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       const TextViewWidget(
                      //         text: 'Playing\n With',
                      //         textSize: 12,
                      //         height: 1.2,
                      //       ),
                      //       const SizedBox(width: 8),
                      //       // VideoBuildStackImages(
                      //       //   direction: TextDirection.rtl,
                      //       //   items: urlImages
                      //       //       .map((urlImage) => const CircularImageWidget(
                      //       //             imageUrl: '',
                      //       //           ))
                      //       //       .toList(),
                      //       // )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  TextViewWidget(text: data.postTitle, textSize: 14),
                  SizedBox(height: 10),
                  TextViewWidget(text: data.caption, textSize: 12),
                  if (data.taggedProfilesDetails.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Wrap(
                        spacing: 4,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: data.taggedProfilesDetails.map((e) {
                          return GestureDetector(
                            onTap: () {
                              ProfileRoute(uuid: e.uuid).push(context);
                            },
                            child: TextViewWidget(
                              text: '@${e.account.username}',
                              color: colorTextRed,
                              textSize: 13,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  SizedBox(height: 24.h),
                  TextViewWidget(
                    text: data.hashtags.map((e) => '#${e.name}').join(' '),
                    color: colorTextRed,
                    textSize: 13,
                  ),
                  SizedBox(height: 20.h),
                  VideoDetailAction(
                    postUuid: data.uuid,
                    isFromOwn: isFromOwn,
                    onShareTap: onShareTap,
                    profileUuid: data.profileUuid,
                    isPrivateProfile: profile.isPrivateProfile,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onShareTap() {
    Share.share('Check out this video ${getVideoShareUrl(data.uuid)}');
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.label,
    this.image,
    this.icon,
    this.onTap,
    this.color,
  });

  final String label;
  final AssetGenImage? image;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var _color = onTap == null ? Colors.grey : color ?? Colors.white;

    return Expanded(
      child: IconButton(
        style: IconButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
        ),
        onPressed: onTap,
        icon: Column(
          children: [
            if (image != null)
              Image.asset(
                image!.path,
                width: 22,
                height: 22,
                color: _color,
              ),
            if (icon != null) Icon(icon!, size: 20, color: _color),
            const SizedBox(height: 4),
            FittedBox(
              child: TextViewWidget(
                text: label,
                textSize: 12.sp,
                color: _color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
