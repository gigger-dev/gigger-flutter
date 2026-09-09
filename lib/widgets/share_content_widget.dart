import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ShareContentSheet extends StatelessWidget {
  const ShareContentSheet({super.key, this.title, required this.uuid});

  final String? title;
  final String uuid;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            colorTextBlack,
            colorTextBlack500,
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: TextViewWidget(
                  text: title ?? 'Share this content',
                  textSize: 15.sp,
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Image.asset(
                      Assets.images.closeIcon.path,
                      color: colorWhite,
                      width: 25,
                      height: 15,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ImageTextTile(
                              imageName: Assets.images.whatsappIcon.path,
                              label: 'Whatsapp',
                            ),
                            ImageTextTile(
                              imageName: Assets.images.linkCopyIcon.path,
                              label: 'Copy link',
                              onTap: onCopyLink,
                            ),
                            ImageTextTile(
                              imageName: Assets.images.giMessage.path,
                              label: 'Message',
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ImageTextTile(
                              imageName: Assets.images.instagramIcon.path,
                              label: 'Instagram',
                            ),
                            ImageTextTile(
                              imageName: Assets.images.facebookIcon.path,
                              label: 'Facebook',
                            ),
                            ImageTextTile(
                              imageName: Assets.images.tiktokIcon.path,
                              label: 'TikTok',
                            ),
                          ],
                        ),
                        SizedBox(height: 35.h),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCopyLink() {
    Clipboard.setData(
      ClipboardData(text: 'https://api.gigger.art/profile/$uuid'),
    );
  }
}

class ImageTextTile extends StatelessWidget {
  const ImageTextTile({
    super.key,
    required this.imageName,
    required this.label,
    this.onTap,
  });

  final String imageName;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imageName,
            color: colorWhite,
            width: 23.h,
            height: 23.h,
          ),
          SizedBox(height: 5.h),
          Text(
            label,
            style: TextStyle(color: colorWhite, fontSize: 13.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
