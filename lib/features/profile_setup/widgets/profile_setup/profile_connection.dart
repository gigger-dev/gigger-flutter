import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/features/profile_setup/providers/profile_setup_controller.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/availability_btn.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/connection_menu.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/edit_bio_btn.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/fab_nine_title.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/profile_info.dart';
import 'package:mobile_gigger_app/models/availability_in.dart';

typedef AvailabilitityCallBack = void Function({
  required bool status,
  required List<AvailabilityIn> availability,
});

class ProfileConnection extends StatelessWidget {
  const ProfileConnection({
    super.key,
    required this.isLast,
    required this.name,
    required this.state,
    required this.onBasicInfoTap,
    required this.onProfileTap,
    required this.onAvailabilityTap,
    required this.onEditDioTap,
  });

  final String name;
  final bool isLast;
  final ProfileSetupState state;
  final ValueChanged<String> onBasicInfoTap;
  final VoidCallback onProfileTap;
  final AvailabilitityCallBack onAvailabilityTap;
  final ValueChanged<ProfileSetupState> onEditDioTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          if (!state.profileType.isCover) SizedBox(height: 0.55.sh),
          ProfileInfo(
            isLast: isLast,
            name: name,
            skills: state.skills,
            location: state.location,
            onBasicInfoTap: () => onBasicInfoTap(name),
            profileImageFile: state.profileImageFile,
            isAvatar: state.profileType.isAvatar,
            isBasicInfo: state.profileType.isBasicInfo,
            onTap: onProfileTap,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            child: ConnectionMenu(isLast: isLast),
          ),
          AvailabilityBtn(
            status: state.availabilityStatus,
            isAvailability: state.profileType.isAvailability,
            isLast: isLast,
            onTap: () => onAvailabilityTap(
              status: state.availabilityStatus,
              availability: state.availability,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: EditBioBtn(
              bio: state.bio,
              isLast: isLast,
              isEditBio: state.profileType.isEditBio,
              onTap: () => onEditDioTap(state),
            ),
          ),
          FabNineTitle(isLast: isLast),
        ],
      ),
    );
  }
}
