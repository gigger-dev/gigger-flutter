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

part 'profile_in.freezed.dart';
part 'profile_in.g.dart';

@Freezed()
abstract class ProfileIn with _$ProfileIn {
  const factory ProfileIn({
    @JsonKey(name: 'cover_media') required String coverMedia,
    @JsonKey(name: 'avatar_media') required String avatarMedia,
    required String bio,
    @JsonKey(name: 'availability_status') required bool availabilityStatus,
    @JsonKey(name: 'custom_phrase') required String customPhrase,
    @JsonKey(name: 'closing_message') required String closingMessage,
    @JsonKey(name: 'account_uuid') required String accountUuid,
    required List<String> interests,
    required List<AvailabilityIn> availability,
    required List<ContactIn> contacts,
    required List<String> services,
    required List<ExperiencesIn> experiences,
    required List<String> skills,
    required List<EducationIn> educations,
    required LocationIn location,
    @JsonKey(name: 'social_links') required List<SocialLinkIn> socialLinks,
    required List<AchievementIn> achievements,
  }) = _ProfileIn;

  factory ProfileIn.fromJson(Map<String, Object?> json) =>
      _$ProfileInFromJson(json);
}
