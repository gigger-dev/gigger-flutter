// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'achievement_in.dart';
import 'availability_in.dart';
import 'contact_in.dart';
import 'education_in.dart';
import 'experiences_in.dart';
import 'location_in.dart';
import 'social_link_in.dart';

part 'profile_update.freezed.dart';
part 'profile_update.g.dart';

@Freezed()
abstract class ProfileUpdate with _$ProfileUpdate {
  const factory ProfileUpdate({
    required String uuid,
    @JsonKey(name: 'cover_media') String? coverMedia,
    @JsonKey(name: 'avatar_media') String? avatarMedia,
    String? bio,
    @JsonKey(name: 'availability_status') bool? availabilityStatus,
    @JsonKey(name: 'custom_phrase') String? customPhrase,
    @JsonKey(name: 'closing_message') String? closingMessage,
    List<String>? interests,
    List<AvailabilityIn>? availability,
    List<ContactIn>? contacts,
    List<String>? services,
    List<ExperiencesIn>? experiences,
    List<String>? skills,
    List<EducationIn>? educations,
    LocationIn? location,
    @JsonKey(name: 'social_links') List<SocialLinkIn>? socialLinks,
    List<AchievementIn>? achievements,
  }) = _ProfileUpdate;

  factory ProfileUpdate.fromJson(Map<String, Object?> json) =>
      _$ProfileUpdateFromJson(json);
}
