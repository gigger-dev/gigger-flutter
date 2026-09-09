import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile_setup/providers/profile_setup_controller.dart';
import 'package:mobile_gigger_app/features/profile_setup/providers/service_provider.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/contact_box.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/edit_text_form.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/form_group.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/service_box.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/social_box.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/social_link_in.dart';
import 'package:mobile_gigger_app/models/social_links.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class EditBioSheet extends ConsumerStatefulWidget {
  const EditBioSheet({super.key});

  @override
  ConsumerState<EditBioSheet> createState() => _EditBioSheetState();
}

class _EditBioSheetState extends ConsumerState<EditBioSheet> {
  final formKey = GlobalKey<FormState>();

  Map<String, TextEditingController> contactMe = {};
  List<String> selectedServices = [];
  List<TextEditingController> experiences = [];
  List<TextEditingController> studies = [];
  List<TextEditingController> achievements = [];

  Map<String, FocusNode> contactMeFocus = {};
  List<FocusNode> experiencesFocus = [];
  List<FocusNode> studiesFocus = [];
  List<FocusNode> achievementsFocus = [];

  final bio = TextEditingController();

  final fb = TextEditingController();
  final yt = TextEditingController();
  final instagram = TextEditingController();
  final tiktok = TextEditingController();
  final twitter = TextEditingController();
  final linkedin = TextEditingController();

  final fbFocus = FocusNode();
  final ytFocus = FocusNode();
  final instagramFocus = FocusNode();
  final tiktokFocus = FocusNode();
  final twitterFocus = FocusNode();
  final linkedinFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    var state = ref.read(profileSetupControllerProvider);

    bio.text = state.bio;

    contactMe = {...state.contacts};
    selectedServices = [...state.services];
    experiences = [...state.experiences];
    studies = [...state.studies];
    achievements = [...state.achievements];

    contactMeFocus = {
      ...state.contacts.map((key, value) => MapEntry(key, FocusNode()))
    };
    experiencesFocus = [...state.experiences.map((e) => FocusNode())];
    studiesFocus = [...state.studies.map((e) => FocusNode())];
    achievementsFocus = [...state.achievements.map((e) => FocusNode())];

    for (var e in state.socialLinks) {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(serviceProvider).whenData((v) => v).value;

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        height: .9.sh,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                  children: [
                    Center(
                      child: Container(
                        height: 2,
                        width: 100,
                        color: colorTextGrey,
                      ),
                    ),
                    const SizedBox(height: 40),
                    EditTextForm(
                      maxLength: 120,
                      controller: bio,
                      label: 'Intro (showed on profile, mandatory)*',
                      hintText: 'Type here max 120 characters ...',
                    ),
                    const SizedBox(height: 50),
                    const TextViewWidget(
                      text: 'Sections (visible here only if fullfilled)',
                      textSize: 15,
                      fontWeight: FontWeight.w500,
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
                    ServiceBox(
                      selected: selectedServices,
                      items: state?.allItems ?? [],
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
                    FormGroup(
                      items: experiences,
                      title: 'Experiences',
                      focus: experiencesFocus,
                      semanticLabel: 'experience_add_btn',
                      hintText: 'Insert your experience ...',
                      onAdd: (_) {
                        experiences.add(TextEditingController());
                        experiencesFocus.add(FocusNode());
                        setState(() {});
                      },
                      onRemove: (index) {
                        experiences.removeAt(index);
                        experiencesFocus.removeAt(index);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 30),
                    FormGroup(
                      items: studies,
                      title: 'Studies',
                      focus: studiesFocus,
                      semanticLabel: 'study_add_btn',
                      hintText: 'Insert here ...',
                      onAdd: (_) {
                        studies.add(TextEditingController());
                        studiesFocus.add(FocusNode());
                        setState(() {});
                      },
                      onRemove: (index) {
                        studies.removeAt(index);
                        studiesFocus.removeAt(index);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 30),
                    FormGroup(
                      items: achievements,
                      title: 'Achievement',
                      focus: achievementsFocus,
                      hintText: 'Insert here ...',
                      semanticLabel: 'achievement_add_btn',
                      onAdd: (_) {
                        achievements.add(TextEditingController());
                        achievementsFocus.add(FocusNode());
                        setState(() {});
                      },
                      onRemove: (index) {
                        achievements.removeAt(index);
                        achievementsFocus.removeAt(index);
                        setState(() {});
                      },
                    ),
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
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                child: GradientFilledButton(
                  key: ValueKey('bio_save_btn'),
                  title: 'Save and continue',
                  onPressed: onSave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSave() {
    if (!formKey.currentState!.validate()) return;

    var social = <SocialLinkIn>[];

    var fb = this.fb.text.trim();
    if (fb.isNotEmpty) {
      social.add(SocialLinkIn(type: SocialLinks.facebook, url: fb));
    }

    var yt = this.yt.text.trim();
    if (yt.isNotEmpty) {
      social.add(SocialLinkIn(type: SocialLinks.youtube, url: yt));
    }

    var instagram = this.instagram.text.trim();
    if (instagram.isNotEmpty) {
      social.add(SocialLinkIn(type: SocialLinks.instagram, url: instagram));
    }

    var tiktok = this.tiktok.text.trim();
    if (tiktok.isNotEmpty) {
      social.add(SocialLinkIn(type: SocialLinks.tiktok, url: tiktok));
    }

    var twitter = this.twitter.text.trim();
    if (twitter.isNotEmpty) {
      social.add(SocialLinkIn(type: SocialLinks.x, url: twitter));
    }

    var linkedin = this.linkedin.text.trim();
    if (linkedin.isNotEmpty) {
      social.add(SocialLinkIn(type: SocialLinks.linkedin, url: linkedin));
    }

    ref.read(profileSetupControllerProvider.notifier).setBioData(
          bio: bio.text.trim(),
          contacts: contactMe,
          experiences: experiences,
          studies: studies,
          socialLinks: social,
          services: selectedServices,
          achievements: achievements,
        );

    context.pop();
  }
}
