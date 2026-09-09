import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/interest/providers/interest_provider.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_edit_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/edit_form_group.dart';
import 'package:mobile_gigger_app/features/profile_setup/providers/service_provider.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/contact_box.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/edit_text_form.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/interest_box.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/service_box.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/social_box.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/achievement_out.dart';
import 'package:mobile_gigger_app/models/contact_out.dart';
import 'package:mobile_gigger_app/models/education_out.dart';
import 'package:mobile_gigger_app/models/experiences_out.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/models/social_link_out.dart';
import 'package:mobile_gigger_app/models/social_links.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class EditBioSheet extends ConsumerStatefulWidget {
  const EditBioSheet({super.key, required this.profile});

  final ProfileOut profile;

  @override
  ConsumerState<EditBioSheet> createState() => _EditBioSheetState();
}

class _EditBioSheetState extends ConsumerState<EditBioSheet> {
  final formKey = GlobalKey<FormState>();

  final bio = TextEditingController();

  Map<String, TextEditingController> contactMe = {};
  List<String> selectedServices = [];
  List<ExperiencesOut> experiences = [];
  List<InterestOut> interests = [];
  List<EducationOut> studies = [];
  List<AchievementOut> achievements = [];

  final fb = TextEditingController();
  final yt = TextEditingController();
  final instagram = TextEditingController();
  final tiktok = TextEditingController();
  final twitter = TextEditingController();
  final linkedin = TextEditingController();

  Map<String, FocusNode> contactMeFocus = {};
  List<FocusNode> experiencesFocus = [];
  List<FocusNode> studiesFocus = [];
  List<FocusNode> achievementsFocus = [];
  List<FocusNode> interestsFocus = [];

  final fbFocus = FocusNode();
  final ytFocus = FocusNode();
  final instagramFocus = FocusNode();
  final tiktokFocus = FocusNode();
  final twitterFocus = FocusNode();
  final linkedinFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    var data = ref.read(profileEditControllerProvider);

    if (data.bio.isNotEmpty) {
      return setData(
        bio: data.bio,
        contacts: data.contacts,
        interests: data.interests,
        myServices: data.services,
        educations: data.educations,
        experiences: data.experiences,
        socialLinks: data.socialLinks,
        achievements: data.achievements,
      );
    }

    var profile = widget.profile;

    setData(
      bio: profile.bio,
      contacts: profile.contacts,
      interests: profile.interests,
      educations: profile.educations,
      experiences: profile.experiences,
      socialLinks: profile.socialLinks,
      achievements: profile.achievements,
      myServices: profile.myServices.map((e) => e.uuid).toList(),
    );
  }

  void setData({
    required String bio,
    required List<ContactOut> contacts,
    required List<String> myServices,
    required List<ExperiencesOut> experiences,
    required List<EducationOut> educations,
    required List<AchievementOut> achievements,
    required List<SocialLinkOut> socialLinks,
    required List<InterestOut> interests,
  }) {
    this.bio.text = bio;

    for (var e in contacts) {
      contactMe[e.type] = TextEditingController(text: e.value);
      contactMeFocus[e.type] = FocusNode();
    }

    selectedServices = myServices;

    for (var e in experiences) {
      this.experiences.add(e);
      experiencesFocus.add(FocusNode());
    }

    for (var e in educations) {
      studies.add(e);
      studiesFocus.add(FocusNode());
    }

    for (var e in achievements) {
      this.achievements.add(e);
      achievementsFocus.add(FocusNode());
    }
    for (var e in interests) {
      this.interests.add(e);
      interestsFocus.add(FocusNode());
    }

    for (var e in socialLinks) {
      switch (e.type) {
        case SocialLinks.facebook:
          fb.text = e.url;
          break;
        case SocialLinks.youtube:
          yt.text = e.url;
          break;
        case SocialLinks.instagram:
          instagram.text = e.url;
          break;
        case SocialLinks.tiktok:
          tiktok.text = e.url;
          break;
        case SocialLinks.x:
          twitter.text = e.url;
          break;
        case SocialLinks.linkedin:
          linkedin.text = e.url;
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var allItems = ref.watch(serviceProvider).whenData((v) => v.allItems).value;
    var interestList =
        ref.watch(interestProvider).valueOrNull?.interestList ?? [];

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
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditTextForm(
                      key: ValueKey('intro'),
                      maxLength: 120,
                      controller: bio,
                      maxLines: null,
                      label: 'Intro*',
                      identifier: 'Intro',
                      hintText: 'Type here max 120 characters ...',
                    ),
                    const SizedBox(height: 30),
                    ContactBox(
                      items: contactMe,
                      focus: contactMeFocus,
                      onAdd: (v) {
                        contactMe[v] = TextEditingController();
                        contactMeFocus[v] = FocusNode();
                        setState(() {});
                      },
                      onRemove: (key) {
                        contactMe.remove(key);
                        contactMeFocus.remove(key);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 30),
                    InterestBox(
                      items: interestList,
                      selected: interests,
                      onRemove: (i) {
                        interests.removeAt(i);
                        setState(() {});
                      },
                      onChanged: (value) {
                        for (var data in value) {
                          if (interests.any((e) => e == data)) continue;
                          interests.add(data);
                        }

                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 30),
                    ServiceBox(
                      items: allItems ?? [],
                      selected: selectedServices,
                      onRemove: (index) {
                        selectedServices.removeAt(index);
                        setState(() {});
                      },
                      onChanged: (value) {
                        selectedServices = value;
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 30),
                    EditFormGroup(
                      items: experiences,
                      title: 'Experiences',
                      focus: experiencesFocus,
                      nameGetter: (e) => e.name,
                      semanticLabel: 'experience_add_btn',
                      hintText: 'Insert your experience ...',
                      onAdd: (_) {
                        experiences.add(ExperiencesOut(name: '', category: ''));
                        experiencesFocus.add(FocusNode());
                        setState(() {});
                      },
                      onRemove: (index) {
                        experiences.removeAt(index);
                        experiencesFocus.removeAt(index);
                        setState(() {});
                      },
                      onSaved: (index, value) {
                        experiences[index] =
                            experiences[index].copyWith(name: value);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 30),
                    EditFormGroup(
                      items: studies,
                      title: 'Studies',
                      focus: studiesFocus,
                      nameGetter: (e) => e.name,
                      hintText: 'Insert here ...',
                      semanticLabel: 'study_add_btn',
                      onAdd: (_) {
                        studies.add(EducationOut(name: '', url: ''));
                        studiesFocus.add(FocusNode());
                        setState(() {});
                      },
                      onRemove: (index) {
                        studies.removeAt(index);
                        studiesFocus.removeAt(index);
                        setState(() {});
                      },
                      onSaved: (index, value) {
                        studies[index] = studies[index].copyWith(name: value);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 30),
                    EditFormGroup(
                      items: achievements,
                      title: 'Achievement',
                      focus: achievementsFocus,
                      nameGetter: (e) => e.name,
                      hintText: 'Insert here ...',
                      semanticLabel: 'achievement_add_btn',
                      onAdd: (_) {
                        achievements.add(AchievementOut(
                          name: '',
                          category: '',
                          url: '',
                          uuid: '',
                        ));
                        achievementsFocus.add(FocusNode());
                        setState(() {});
                      },
                      onRemove: (index) {
                        achievements.removeAt(index);
                        achievementsFocus.removeAt(index);
                        setState(() {});
                      },
                      onSaved: (index, value) {
                        achievements[index] =
                            achievements[index].copyWith(name: value);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 30),
                    // CustomTitleWidget(
                    //   title: provider.customTileController,
                    //   note: provider.customNoteController,
                    //   isEdit: provider.editIndex == 6,
                    //   onEdit: () {
                    //     provider.editIndex = 6;
                    //     setState(() {});
                    //   },
                    //   onRemove: (int index) {
                    //     provider.customTileController.removeAt(index);
                    //     provider.customNoteController.removeAt(index);
                    //     setState(() {});
                    //   },
                    // ),
                    // if (provider.editIndex == 6)
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 30),
                    //   child: CupertinoButton(
                    //     onPressed: () {
                    //       provider.customTileController
                    //           .add(TextEditingController());
                    //       provider.customNoteController
                    //           .add(TextEditingController());
                    //       setState(() {});
                    //     },
                    //     child: const Center(
                    //       child: TextViewWidget(
                    //         text: "+",
                    //         textSize: 50,
                    //         fontWeight: FontWeight.w100,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 30),
                    const TextViewWidget(
                      text: 'Social links',
                      textSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    const TextViewWidget(
                      text: 'Tap and insert related link to any selected',
                      color: colorTextGrey,
                      textSize: 12,
                    ),
                    const SizedBox(height: 20),
                    SocialBox(
                      focus: fbFocus,
                      controller: fb,
                      focusIcon: Assets.images.selectedFacebook,
                      icon: Assets.images.unselectedFacebook,
                    ),
                    const SizedBox(height: 14),
                    SocialBox(
                      focus: ytFocus,
                      controller: yt,
                      focusIcon: Assets.images.youtubeIcon,
                      icon: Assets.images.youtubeIcon,
                      isBorder: true,
                    ),
                    const SizedBox(height: 14),
                    SocialBox(
                      focus: instagramFocus,
                      controller: instagram,
                      focusIcon: Assets.images.selectedInstagram,
                      icon: Assets.images.unselectedInstagram,
                    ),
                    const SizedBox(height: 14),
                    SocialBox(
                      controller: tiktok,
                      focus: tiktokFocus,
                      focusIcon: Assets.images.selectedTiktok,
                      icon: Assets.images.unselectedTiktok,
                    ),
                    const SizedBox(height: 14),
                    SocialBox(
                      padding: 2,
                      isBorder: true,
                      controller: twitter,
                      focus: twitterFocus,
                      icon: Assets.images.xIcon,
                      focusColor: colorWhite,
                    ),
                    const SizedBox(height: 14),
                    SocialBox(
                      focus: linkedinFocus,
                      controller: linkedin,
                      focusIcon: Assets.images.selectedLinkedin,
                      icon: Assets.images.unselectedLinkedin,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: GradientFilledButton(
              key: ValueKey('bio_save_btn'),
              title: 'Save and continue',
              onPressed: onSave,
            ),
          ),
        ],
      ),
    );
  }

  void onSave() {
    if (!formKey.currentState!.validate()) return;

    var social = <SocialLinkOut>[];

    var fb = this.fb.text.trim();
    if (fb.isNotEmpty) {
      social.add(SocialLinkOut(type: SocialLinks.facebook, url: fb));
    }

    var yt = this.yt.text.trim();
    if (yt.isNotEmpty) {
      social.add(SocialLinkOut(type: SocialLinks.youtube, url: yt));
    }

    var instagram = this.instagram.text.trim();
    if (instagram.isNotEmpty) {
      social.add(SocialLinkOut(type: SocialLinks.instagram, url: instagram));
    }

    var tiktok = this.tiktok.text.trim();
    if (tiktok.isNotEmpty) {
      social.add(SocialLinkOut(type: SocialLinks.tiktok, url: tiktok));
    }

    var twitter = this.twitter.text.trim();
    if (twitter.isNotEmpty) {
      social.add(SocialLinkOut(type: SocialLinks.x, url: twitter));
    }

    var linkedin = this.linkedin.text.trim();
    if (linkedin.isNotEmpty) {
      social.add(SocialLinkOut(type: SocialLinks.linkedin, url: linkedin));
    }

    context.pop([
      bio.text.trim(),
      contactMe,
      experiences,
      studies,
      social,
      selectedServices,
      achievements,
      interests,
    ]);
  }
}
