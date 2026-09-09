// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile_gigger_app/models/achievement_out.dart';
import 'package:mobile_gigger_app/models/availability_out.dart';
import 'package:mobile_gigger_app/models/contact_out.dart';
import 'package:mobile_gigger_app/models/education_out.dart';
import 'package:mobile_gigger_app/models/experiences_out.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';
import 'package:mobile_gigger_app/models/social_link_out.dart';

part 'profile_edit_controller.g.dart';

@Riverpod(keepAlive: true)
class ProfileEditController extends _$ProfileEditController {
  @override
  ProfileEditState build() => ProfileEditState.init();

  void startEdit() {
    state = ProfileEditState.init().copyWith(isEditMode: true);
  }

  void dismiss() {
    state = ProfileEditState.init();
  }

  void setBioData({
    required String bio,
    required List<ContactOut> contacts,
    required List<ExperiencesOut> experiences,
    required List<String> services,
    required List<EducationOut> educations,
    required List<AchievementOut> achievements,
    required List<SocialLinkOut> socialLinks,
    required List<InterestOut> interests,
  }) {
    state = state.copyWith(
      bio: bio,
      contacts: contacts,
      services: services,
      interests: interests,
      educations: educations,
      experiences: experiences,
      socialLinks: socialLinks,
      achievements: achievements,
    );
  }

  Future<void> cover(File file, Size size) async {
    state = state.copyWith(
      coverFile: file,
      isCoverEdit: true,
      coverFileSize: size,
      coverFileName: p.basename(file.path),
    );
  }

  void coverFile(MemoryImage file) {
    state = state.copyWith(coverImageFile: file, isCoverEdit: false);
  }

  void customPhrase(String value) {
    state = state.copyWith(customPhrase: value);
  }

  void closingMessage(String value) {
    state = state.copyWith(closingMessage: value);
  }

  void availability({
    required bool status,
    required List<AvailabilityOut> availability,
  }) {
    state = state.copyWith(
      availabilityStatus: status,
      availability: availability,
    );
  }
}

class ProfileEditState {
  final bool isEditMode;
  final bool isCoverEdit;

  final bool? availabilityStatus;
  final List<AvailabilityOut>? availability;

  final String bio;
  final String? customPhrase;
  final String? closingMessage;
  final List<String> services;
  final List<ContactOut> contacts;
  final List<EducationOut> educations;
  final List<ExperiencesOut> experiences;
  final List<SocialLinkOut> socialLinks;
  final List<AchievementOut> achievements;
  final List<InterestOut> interests;

  final File? coverFile;
  final Size? coverFileSize;
  final String? coverFileName;
  final MemoryImage? coverImageFile;

  ProfileEditState({
    required this.isEditMode,
    required this.isCoverEdit,
    this.availabilityStatus,
    this.availability,
    required this.bio,
    this.customPhrase,
    this.closingMessage,
    required this.services,
    required this.contacts,
    required this.educations,
    required this.experiences,
    required this.socialLinks,
    required this.achievements,
    required this.interests,
    this.coverFile,
    this.coverFileSize,
    this.coverFileName,
    this.coverImageFile,
  });

  factory ProfileEditState.init() {
    return ProfileEditState(
      bio: '',
      services: [],
      contacts: [],
      interests: [],
      educations: [],
      experiences: [],
      socialLinks: [],
      achievements: [],
      isEditMode: false,
      isCoverEdit: false,
    );
  }
  ProfileEditState copyWith({
    bool? isEditMode,
    bool? isCoverEdit,
    bool? availabilityStatus,
    List<AvailabilityOut>? availability,
    String? bio,
    String? customPhrase,
    String? closingMessage,
    List<String>? services,
    List<ContactOut>? contacts,
    List<EducationOut>? educations,
    List<ExperiencesOut>? experiences,
    List<SocialLinkOut>? socialLinks,
    List<AchievementOut>? achievements,
    List<InterestOut>? interests,
    File? coverFile,
    Size? coverFileSize,
    String? coverFileName,
    MemoryImage? coverImageFile,
  }) {
    return ProfileEditState(
      isEditMode: isEditMode ?? this.isEditMode,
      isCoverEdit: isCoverEdit ?? this.isCoverEdit,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      availability: availability ?? this.availability,
      bio: bio ?? this.bio,
      customPhrase: customPhrase ?? this.customPhrase,
      closingMessage: closingMessage ?? this.closingMessage,
      services: services ?? this.services,
      contacts: contacts ?? this.contacts,
      educations: educations ?? this.educations,
      experiences: experiences ?? this.experiences,
      socialLinks: socialLinks ?? this.socialLinks,
      achievements: achievements ?? this.achievements,
      interests: interests ?? this.interests,
      coverFile: coverFile ?? this.coverFile,
      coverFileSize: coverFileSize ?? this.coverFileSize,
      coverFileName: coverFileName ?? this.coverFileName,
      coverImageFile: coverImageFile ?? this.coverImageFile,
    );
  }
}

// / / var editBioProvider = ChangeNotifierProvider((ref) {
//   return EditBio();
// });

// class EditBio extends ChangeNotifier {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController highlightController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController introNoteController = TextEditingController();
//   TextEditingController callMeNoteController = TextEditingController();
//   List<TextEditingController> servicesNoteController = [];
//   List<TextEditingController> expNoteController = [];
//   List<TextEditingController> studiesNoteController = [];
//   List<TextEditingController> achieveNoteController = [];
//   List<TextEditingController> customNoteController = [];
//   List<TextEditingController> customTileController = [];

//   final List<BioData> _dataList = [];

//   List<BioData> get dataList => _dataList;

//   int editIndex = -1;
//   bool canAddNewBio = false;

//   bool isEditBio = false;

//   void getTitleList(ProfileData profileData) {
//     nameController.text = profileData.username ?? '';
//     highlightController.text = profileData.highlight ?? '';
//     addressController.text = profileData.address ?? '';

//     introNoteController.text = profileData.description?.trim() ?? '';

//     callMeNoteController.text = profileData.phone?.toString().trim() ?? '';

//     servicesNoteController = profileData.services
//         .map((e) => TextEditingController(text: e))
//         .toList();

//     expNoteController.clear();
//     for (var e in profileData.experiences) {
//       expNoteController.add(
//         TextEditingController(text: e is Map ? e['role'] : e),
//       );
//     }

//     studiesNoteController.clear();
//     for (var e in profileData.studies) {
//       studiesNoteController.add(
//         TextEditingController(text: e is Map ? e['degree'] : e),
//       );
//     }

//     achieveNoteController.clear();
//     for (var e in profileData.achievements) {
//       achieveNoteController.add(
//         TextEditingController(text: e is Map ? e['title'] : e),
//       );
//     }

//     customTileController.clear();
//     customNoteController.clear();
//     for (var e in profileData.customTitle ?? <CustomTitle>[]) {
//       customTileController.add(TextEditingController(text: e.label));
//       customNoteController.add(TextEditingController(text: e.value));
//     }

//     canAdd();
//   }

//   void addNewBio(int index) {
//     _dataList[index].isRemove = false;
//     canAdd();
//     notifyListeners();
//   }

//   void canAdd() {
//     canAddNewBio = false;
//     for (final data in _dataList) {
//       if (data.isRemove!) {
//         canAddNewBio = true;
//         break;
//       }
//     }
//   }

//   void resetEditData(ProfileData profileData) {
//     return getTitleList(profileData);
//   }
// }
