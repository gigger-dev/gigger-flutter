// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'account_out.dart';
import 'achievement_out.dart';
import 'availability_out.dart';
import 'contact_out.dart';
import 'education_out.dart';
import 'experiences_out.dart';
import 'interest_out.dart';
import 'location_out.dart';
import 'my_services_out.dart';
import 'skill_out.dart';
import 'social_link_out.dart';

part 'profile_out.freezed.dart';
part 'profile_out.g.dart';

@Freezed()
abstract class ProfileOut with _$ProfileOut {
  const factory ProfileOut({
    @JsonKey(name: 'cover_media') required String coverMedia,
    @JsonKey(name: 'avatar_media') required String avatarMedia,
    required String bio,
    @JsonKey(name: 'availability_status') required bool availabilityStatus,
    @JsonKey(name: 'custom_phrase') required String customPhrase,
    @JsonKey(name: 'closing_message') required String closingMessage,
    required String uuid,
    @JsonKey(name: 'account_uuid') required String accountUuid,
    required LocationOut location,
    required List<InterestOut> interests,
    required List<AvailabilityOut> availability,
    required List<ContactOut> contacts,
    required List<ExperiencesOut> experiences,
    required List<EducationOut> educations,
    required List<SkillOut> skills,
    @JsonKey(name: 'social_links') required List<SocialLinkOut> socialLinks,
    @JsonKey(name: 'my_services') required List<MyServicesOut> myServices,
    required List<AchievementOut> achievements,
    required AccountOut account,
    @JsonKey(name: 'is_private_profile') required bool isPrivateProfile,
  }) = _ProfileOut;

  factory ProfileOut.fromJson(Map<String, Object?> json) =>
      _$ProfileOutFromJson(json);
}
