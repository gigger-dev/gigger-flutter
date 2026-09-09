import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/models/skill_out.dart';
import 'package:mobile_gigger_app/widgets/circular_image_widget.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class VideoInfo extends StatelessWidget {
  const VideoInfo({
    super.key,
    required this.onTap,
    required this.avatarMedia,
    required this.username,
    required this.skills,
    this.actionIcon,
  });

  final String username;
  final String avatarMedia;
  final VoidCallback onTap;
  final List<SkillOut> skills;
  final IconData? actionIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CircularImageWidget(imageUrl: avatarMedia),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextViewWidget(
                    text: username,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    shadows: const [BoxShadow(blurRadius: 10)],
                  ),
                  const SizedBox(height: 1),
                  TextViewWidget(
                    text: skills.map((e) => e.name).join(', '),
                    textSize: 12.sp,
                    shadows: const [BoxShadow(blurRadius: 10)],
                  ),
                ],
              ),
            ),
            Icon(
              actionIcon ?? Icons.keyboard_arrow_up_outlined,
              color: Colors.white,
              size: 40,
              shadows: [BoxShadow(blurRadius: 10)],
            )
          ],
        ),
      ),
    );
  }
}
