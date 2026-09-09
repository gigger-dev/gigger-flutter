import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialListWidget extends StatelessWidget {
  const SocialListWidget(this.items, {super.key});

  final Map<String, String> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return SizedBox();

    return Column(
      children: [
        TextViewWidget(text: 'Social', textSize: 13.sp),
        SizedBox(height: 20.sp),
        Row(
          children: items.keys.map((e) {
            String icon;

            if (e == 'facebook') {
              icon = Assets.images.facebookIcon.path;
            } else if (e == 'youtube') {
              icon = Assets.images.youtubeIcon.path;
            } else if (e == 'instagram') {
              icon = Assets.images.instagramIcon.path;
            } else if (e == 'tiktok') {
              icon = Assets.images.tiktokIcon.path;
            } else if (e == 'x') {
              icon = Assets.images.xIcon.path;
            } else {
              icon = Assets.images.unselectedLinkedin.path;
            }

            return GestureDetector(
              onTap: () => onSocialTap(items[e]!),
              child: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorRed,
                ),
                child: Image.asset(icon, color: colorWhite),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  Future<void> onSocialTap(String url) async {
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    }
  }
}
