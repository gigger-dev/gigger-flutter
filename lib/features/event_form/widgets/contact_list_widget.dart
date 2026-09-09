import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/event_form/providers/event_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class ContactListWidget extends ConsumerWidget {
  const ContactListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var profile = ref.watch(profileControllerProvider).value!;
    if (profile.contacts.isEmpty) return SizedBox();

    var contacts =
        ref.watch(eventFormControllerProvider.select((v) => v.contacts));

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: profile.contacts.length,
        itemBuilder: (context, index) {
          var data = profile.contacts[index];

          return _SocialItem(
            img: Assets.images.unselectedFacebook,
            selected: contacts.containsKey(data.type),
            activeImg: Assets.images.selectedFacebook,
            onTap: (v) {
              ref.read(eventFormControllerProvider.notifier).contact(data, v);
            },
          );
        },
      ),
    );
  }
}

class _SocialItem extends StatelessWidget {
  const _SocialItem({
    required this.img,
    required this.activeImg,
    required this.selected,
    required this.onTap,
  });

  final bool selected;
  final AssetGenImage img;
  final AssetGenImage activeImg;
  final ValueChanged<bool> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(!selected),
      child: Image.asset(
        selected ? activeImg.path : img.path,
        width: 40,
      ),
    );
  }
}
