import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/models/location_in.dart';
import 'package:mobile_gigger_app/models/skill_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.isBasicInfo,
    required this.isAvatar,
    required this.isLast,
    required this.onTap,
    required this.profileImageFile,
    required this.onBasicInfoTap,
    required this.name,
    required this.skills,
    required this.location,
  });

  final String name;
  final bool isBasicInfo;
  final bool isAvatar;
  final bool isLast;
  final VoidCallback onTap;
  final LocationIn? location;
  final List<SkillOut> skills;
  final VoidCallback onBasicInfoTap;
  final MemoryImage? profileImageFile;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Avatar(
          isAvatar: isAvatar,
          isLast: isLast,
          onTap: onTap,
          profileImageFile: profileImageFile,
        ),
        SizedBox(width: 10.w),
        _Info(
          isBasicInfo: isBasicInfo,
          isLast: isLast,
          onBasicInfoTap: onBasicInfoTap,
          name: name,
          skills: skills,
          location: location,
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    required this.isBasicInfo,
    required this.isLast,
    required this.onBasicInfoTap,
    required this.name,
    required this.skills,
    required this.location,
  });

  final bool isBasicInfo;
  final bool isLast;
  final VoidCallback onBasicInfoTap;
  final String name;
  final List<SkillOut> skills;
  final LocationIn? location;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: isBasicInfo || isLast ? 1 : .2,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: isBasicInfo || isLast ? onBasicInfoTap : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextViewWidget(text: name),
                TextViewWidget(
                  text: skills.isEmpty
                      ? 'Describe yourself briefly here ...'
                      : skills.map((e) => e.name).join(', '),
                  textSize: 12,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14),
                    const SizedBox(width: 2),
                    TextViewWidget(
                      text: location?.city ?? 'Insert Location here ...',
                      textSize: 12,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (isBasicInfo)
                  const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: TextViewWidget(
                      text: 'Edit basic info*',
                      color: colorRed,
                      textSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.isAvatar,
    required this.isLast,
    required this.onTap,
    required this.profileImageFile,
  });

  final bool isAvatar;
  final bool isLast;
  final VoidCallback onTap;
  final MemoryImage? profileImageFile;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isAvatar || isLast ? 1 : .2,
      child: GestureDetector(
        onTap: isAvatar || isLast ? onTap : null,
        child: Column(
          children: [
            CircleAvatar(
              radius: 38,
              backgroundColor: colorTransparent,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colorWhite),
                  image: profileImageFile == null
                      ? null
                      : DecorationImage(
                          image: profileImageFile!,
                          fit: BoxFit.cover,
                        ),
                ),
                alignment: Alignment.center,
                child: profileImageFile != null
                    ? null
                    : const Icon(
                        CupertinoIcons.add,
                        size: 30,
                        color: colorWhite,
                      ),
              ),
            ),
            if (isAvatar)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextViewWidget(
                  text: 'Add avatar*',
                  color: colorRed,
                  textSize: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
