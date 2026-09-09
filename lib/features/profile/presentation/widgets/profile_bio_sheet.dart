import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/models/social_link_out.dart';
import 'package:mobile_gigger_app/models/social_links.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileBioSheet extends StatelessWidget {
  const ProfileBioSheet({super.key, required this.profile});

  final ProfileOut profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            colorTextBlack.withOpacity(.9),
            colorTextBlack500.withOpacity(.9),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          SizedBox(height: 15.h),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100.w,
              height: 1,
              color: colorWhite,
            ),
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(30.w, 35.h, 30.w, 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextViewWidget(text: 'Intro'),
                  SizedBox(height: 10),
                  TextViewWidget(text: profile.bio, textSize: 12),
                  SizedBox(height: 30),
                  _SheetItemList(
                    title: 'Contact me!',
                    items: profile.contacts
                        .map((e) => '${e.type} ${e.value}')
                        .toList(),
                  ),
                  SizedBox(height: 30),
                  _SheetItemList(
                    title: 'Musical Preferences',
                    items: profile.interests.map((e) => e.name).toList(),
                  ),
                  SizedBox(height: 30),
                  _SheetItemList(
                    title: 'What I can do',
                    items: profile.myServices.map((e) => e.name).toList(),
                  ),
                  SizedBox(height: 30),
                  _SheetItemList(
                    title: 'Experiences',
                    items: profile.experiences.map((e) => e.name).toList(),
                  ),
                  SizedBox(height: 30),
                  _SheetItemList(
                    title: 'Studies',
                    items: profile.educations.map((e) => e.name).toList(),
                  ),
                  SizedBox(height: 30),
                  _SheetItemList(
                    title: 'Achievements',
                    items: profile.achievements.map((e) => e.name).toList(),
                  ),
                  const SizedBox(height: 30),
                  _SocialLinks(profile.socialLinks),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetItemList extends StatelessWidget {
  const _SheetItemList({
    required this.title,
    required this.items,
  });

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextViewWidget(text: title),
        SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          itemCount: items.length,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => SizedBox(height: 4),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colorRed),
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: TextViewWidget(text: items[index], textSize: 12),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SocialLinks extends StatelessWidget {
  const _SocialLinks(this.socialLinks);

  final List<SocialLinkOut> socialLinks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextViewWidget(text: 'Social links'),
        SizedBox(height: 10),
        Row(
          children: socialLinks.map((e) {
            String icon;
            bool padding = false;

            if (e.type == SocialLinks.facebook) {
              icon = Assets.images.unselectedFacebook.path;
            } else if (e.type == SocialLinks.youtube) {
              icon = Assets.images.youtubeIcon.path;
              padding = true;
            } else if (e.type == SocialLinks.instagram) {
              icon = Assets.images.unselectedInstagram.path;
            } else if (e.type == SocialLinks.tiktok) {
              icon = Assets.images.unselectedTiktok.path;
            } else if (e.type == SocialLinks.x) {
              icon = Assets.images.xIcon.path;
              padding = true;
            } else {
              icon = Assets.images.unselectedLinkedin.path;
            }

            return GestureDetector(
              onTap: () => onSocialTap(e),
              child: Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colorWhite),
                ),
                padding: !padding ? null : EdgeInsets.all(6),
                child: Image.asset(icon, color: colorWhite),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> onSocialTap(SocialLinkOut e) async {
    if (await canLaunchUrlString(e.url)) {
      launchUrlString(e.url);
    }
  }
}
