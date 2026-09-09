import 'package:mobile_gigger_app/models/achievement_in.dart';
import 'package:mobile_gigger_app/models/availability_in.dart';
import 'package:mobile_gigger_app/models/contact_in.dart';
import 'package:mobile_gigger_app/models/education_in.dart';
import 'package:mobile_gigger_app/models/experiences_in.dart';
import 'package:mobile_gigger_app/models/location_in.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/models/profile_update.dart';
import 'package:mobile_gigger_app/models/social_link_in.dart';

ProfileUpdate profileOut2Update(ProfileOut profile) {
  return ProfileUpdate(
    uuid: profile.uuid,
    achievements: profile.achievements.map((e) {
      return AchievementIn(name: e.name, category: e.category, url: e.url);
    }).toList(),
    availability: profile.availability.map((e) {
      return AvailabilityIn.fromJson(e.toJson());
    }).toList(),
    availabilityStatus: profile.availabilityStatus,
    avatarMedia: profile.avatarMedia,
    bio: profile.bio,
    closingMessage: profile.closingMessage,
    contacts: profile.contacts.map((e) {
      return ContactIn(value: e.value, type: e.type);
    }).toList(),
    coverMedia: profile.coverMedia,
    customPhrase: profile.customPhrase,
    educations: profile.educations.map((e) {
      return EducationIn(name: e.name, url: e.url);
    }).toList(),
    experiences: profile.experiences.map((e) {
      return ExperiencesIn(name: e.name, category: e.category);
    }).toList(),
    interests: profile.interests.map((e) => e.uuid).toList(),
    location: LocationIn(
      address: profile.location.address,
      country: profile.location.country,
      city: profile.location.city,
      state: profile.location.state,
    ),
    services: profile.myServices.map((e) => e.uuid).toList(),
    skills: profile.skills.map((e) => e.uuid).toList(),
    socialLinks: profile.socialLinks
        .map((e) => SocialLinkIn(type: e.type, url: e.url))
        .toList(),
  );
}
