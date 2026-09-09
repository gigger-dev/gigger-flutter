import 'package:cached_network_image/cached_network_image.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/core/utils/profile_out_2_update.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/profile_setup/providers/profile_setup_controller.dart';
import 'package:mobile_gigger_app/features/profile_setup/providers/skill_provider.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/skill_sheet.dart';
import 'package:mobile_gigger_app/models/location_in.dart';
import 'package:mobile_gigger_app/models/skill_out.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';

class BasicInfoFormSheet extends ConsumerStatefulWidget {
  const BasicInfoFormSheet({
    super.key,
    required this.name,
    this.skills,
    this.location,
    this.avatarMedia,
    this.isModify = false,
  });

  final String name;
  final String? avatarMedia;
  final List<SkillOut>? skills;
  final LocationIn? location;
  final bool isModify;

  @override
  ConsumerState<BasicInfoFormSheet> createState() => _BasicInfoFormSheetState();
}

class _BasicInfoFormSheetState extends ConsumerState<BasicInfoFormSheet> {
  late MemoryImage? profileImageFile;

  final formKey = GlobalKey<FormState>();

  late TextEditingController address;

  List<SkillOut> skills = [];

  String? city;
  String? country;
  String? state;
  String? avatarMedia;

  @override
  void initState() {
    super.initState();

    var state = ref.read(profileSetupControllerProvider);

    if (widget.skills != null) {
      skills = widget.skills!;
    } else {
      skills = state.skills;
    }

    var location = widget.location ?? state.location;

    city = location?.city;
    country = location?.country;
    this.state = location?.state;
    address = TextEditingController(text: location?.address);

    if (widget.avatarMedia != null) {
      avatarMedia = widget.avatarMedia;
    } else {
      profileImageFile = state.profileImageFile;
    }
  }

  @override
  Widget build(BuildContext context) {
    var items =
        ref.watch(skillProvider).whenData((v) => v.allItems).value ?? [];

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(
        20,
        30,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: CupertinoButton(
                    minSize: 0,
                    onPressed: context.pop,
                    padding: EdgeInsets.zero,
                    child: Icon(Icons.clear, color: Colors.white, size: 30),
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: TextViewWidget(
                    text: 'Edit basic info*',
                    textAlign: TextAlign.center,
                    textSize: 16,
                    height: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 36,
              backgroundColor: colorTransparent,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colorWhite),
                  image: avatarMedia != null
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(avatarMedia!),
                        )
                      : profileImageFile != null
                          ? DecorationImage(image: profileImageFile!)
                          : null,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(child: TextViewWidget(text: widget.name)),
            const SizedBox(height: 50),
            _DescribeBox(
              items: items,
              selected: skills,
              onChanged: (value) {
                skills = value;
                setState(() {});
              },
            ),
            const SizedBox(height: 30),
            const TextViewWidget(
              text: 'Your location*',
              textSize: 15,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 10),
            _CountryPicker(
              city: city,
              country: country,
              state: state,
              onCityChanged: (value) {
                city = value;
                setState(() {});
              },
              onCountryChanged: (value) {
                country = value;
                setState(() {});
              },
              onStateChanged: (value) {
                state = value;
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: address,
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Address',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                hintStyle: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 40),
            GradientFilledButton(
              title: 'Continue',
              onPressed: onContinueTap,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onContinueTap() async {
    if (!formKey.currentState!.validate()) return;

    if (skills.isEmpty) {
      Toast.error('Select Skills');
      return;
    }

    if (country == null || city == null || state == null) {
      Toast.error('Select Location');
      return;
    }

    var location = LocationIn(
      address: address.text.trim(),
      country: country!,
      city: city!,
      state: state!,
    );

    // for profile setup
    if (!widget.isModify) {
      ref.read(profileSetupControllerProvider.notifier).skills(skills);
      ref.read(profileSetupControllerProvider.notifier).location(location);
      context.pop();
      return;
    }

    try {
      DialogHelper.showOverlay(context);

      var profile = await ref.read(profileControllerProvider.future);
      var model = profileOut2Update(profile!.copyWith(skills: skills))
          .copyWith(location: location);

      await ref.read(profileControllerProvider.notifier).updateProfile(model);

      if (!mounted) return;

      DialogHelper.hideLoading(context);

      context.pop();
    } catch (e) {
      DialogHelper.hideLoading(context);

      Toast.error(e.toString());
    }
  }
}

class _DescribeBox extends StatelessWidget {
  const _DescribeBox({
    required this.selected,
    required this.items,
    required this.onChanged,
  });

  final List<SkillOut> items;
  final List<SkillOut> selected;
  final ValueChanged<List<SkillOut>> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextViewWidget(
          textSize: 15,
          fontWeight: FontWeight.w500,
          text: 'Describe yourself briefly*',
        ),
        SizedBox(height: selected.isEmpty ? 4 : 8),
        GestureDetector(
          onTap: () => onTap(context),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: colorWhite)),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: selected.isEmpty ? 2 : 8),
            child: selected.isEmpty
                ? TextViewWidget(
                    text: 'eg. Guitarist, Record Label, Management ...',
                    color: colorWhite.withOpacity(0.5),
                  )
                : Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: selected.map((s) {
                      return _SkillItem(
                        data: s,
                        onTap: () => onChanged(List.from(selected)..remove(s)),
                      );
                    }).toList(),
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> onTap(BuildContext context) async {
    var value = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SkillSheet(
        initialValue: selected.map((e) => e.uuid).toList(),
      ),
    );

    if (value == null) return;

    var data = <SkillOut>[];

    for (var e in value) {
      var item = items.where((v) => v.uuid == e).firstOrNull;
      if (item == null) continue;

      data.add(item);
    }

    onChanged(data);
  }
}

class _SkillItem extends StatelessWidget {
  const _SkillItem({required this.data, required this.onTap});

  final SkillOut data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorRed,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextViewWidget(text: data.name, textSize: 14),
            SizedBox(width: 4),
            Icon(Icons.clear, size: 18),
          ],
        ),
      ),
    );
  }
}

class _CountryPicker extends StatelessWidget {
  const _CountryPicker({
    this.city,
    this.country,
    this.state,
    required this.onCityChanged,
    required this.onCountryChanged,
    required this.onStateChanged,
  });

  final String? city;
  final String? country;
  final String? state;
  final ValueChanged<String?> onCityChanged;
  final ValueChanged<String?> onCountryChanged;
  final ValueChanged<String?> onStateChanged;

  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      dropdownDecoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(4),
        border: const Border(bottom: BorderSide(color: colorWhite)),
      ),
      disabledDropdownDecoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(4),
        border: const Border(bottom: BorderSide(color: colorWhite)),
      ),
      flagState: CountryFlag.DISABLE,
      currentCity: city,
      currentCountry: country,
      currentState: state,
      onCityChanged: onCityChanged,
      onCountryChanged: onCountryChanged,
      onStateChanged: onStateChanged,
    );
  }
}
