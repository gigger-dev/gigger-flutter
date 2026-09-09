import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_gigger_app/features/profile_setup/profile_setup_screen.dart';
import 'package:mobile_gigger_app/models/availability_in.dart';
import 'package:mobile_gigger_app/models/availability_out.dart';
import 'package:mobile_gigger_app/models/location_in.dart';
import 'package:mobile_gigger_app/models/skill_out.dart';
import 'package:mobile_gigger_app/models/social_link_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_setup_controller.g.dart';
part 'profile_setup_controller.freezed.dart';

@Riverpod(keepAlive: true)
class ProfileSetupController extends _$ProfileSetupController {
  @override
  ProfileSetupState build() => ProfileSetupState.init();

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
      availability: availability.map((e) {
        return AvailabilityIn(
          day: e.day,
          startTime: e.startTime,
          endTime: e.endTime,
        );
      }).toList(),
    );
  }

  void removeCoverImage() {
    state = state.copyWith(coverImageFile: null, coverImageFinalFile: null);
  }

  void location(LocationIn location) {
    state = state.copyWith(location: location);
  }

  void skills(List<SkillOut> skills) {
    state = state.copyWith(skills: skills);
  }

  void coverImageFile(File? file) {
    state = state.copyWith(coverImageFile: file);
  }

  void profileImageFile(MemoryImage image) {
    state = state.copyWith(profileImageFile: image);
  }

  void setBioData({
    required Map<String, TextEditingController> contacts,
    required List<TextEditingController> experiences,
    required List<TextEditingController> studies,
    required List<SocialLinkIn> socialLinks,
    required List<String> services,
    required List<TextEditingController> achievements,
    required String bio,
  }) {
    state = state.copyWith(
      bio: bio,
      contacts: contacts,
      experiences: experiences,
      studies: studies,
      socialLinks: socialLinks,
      services: services,
      achievements: achievements,
    );
  }

  void coverImageFinalFile(MemoryImage? image) {
    state = state.copyWith(coverImageFinalFile: image);
  }

  void profileType(ProfileType type) {
    state = state.copyWith(profileType: type);
  }

  void isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void loadingMsg(String? msg) {
    state = state.copyWith(loadingMsg: msg);
  }

  void setMottoData({
    bool? closingMessageEdit,
    bool? customPhraseEdit,
    String? customPhrase,
    String? closingMessage,
  }) {
    if (closingMessageEdit != null) {
      state = state.copyWith(closingMessageEdit: closingMessageEdit);
    }
    if (customPhraseEdit != null) {
      state = state.copyWith(customPhraseEdit: customPhraseEdit);
    }
    if (customPhrase != null) {
      state = state.copyWith(customPhrase: customPhrase);
    }
    if (closingMessage != null) {
      state = state.copyWith(closingMessage: closingMessage);
    }
  }
}

@Freezed(fromJson: false, toJson: false)
class ProfileSetupState with _$ProfileSetupState {
  factory ProfileSetupState({
    required ProfileType profileType,
    required String bio,
    File? coverImageFile,
    MemoryImage? profileImageFile,
    MemoryImage? coverImageFinalFile,
    String? customPhrase,
    String? closingMessage,
    required Map<String, TextEditingController> contacts,
    required List<TextEditingController> experiences,
    required List<TextEditingController> achievements,
    required List<TextEditingController> studies,
    required List<SocialLinkIn> socialLinks,
    required bool availabilityStatus,
    required List<SkillOut> skills,
    required List<String> services,
    required List<AvailabilityIn> availability,
    LocationIn? location,
    required bool isLoading,
    required bool customPhraseEdit,
    required bool closingMessageEdit,
    String? loadingMsg,
  }) = _FirstTimeState;

  factory ProfileSetupState.init() {
    return ProfileSetupState(
      contacts: {},
      bio: '',
      experiences: [],
      achievements: [],
      socialLinks: [],
      skills: [],
      services: [],
      studies: [],
      availability: [],
      availabilityStatus: true,
      profileType: ProfileType.cover,
      isLoading: false,
      customPhraseEdit: false,
      closingMessageEdit: false,
    );
  }
}
