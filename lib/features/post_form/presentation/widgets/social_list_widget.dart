import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/features/event_form/providers/event_form_controller.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class SocialListWidget extends ConsumerWidget {
  const SocialListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(eventFormControllerProvider);

    var selectSocial = state.selectSocial;
    var socialLinks = state.socialLinks;

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _SocialItem(
                label: 'facebook',
                img: Assets.images.facebookIcon,
              ),
              const SizedBox(width: 20),
              _SocialItem(
                label: 'youtube',
                img: Assets.images.youtubeIcon,
              ),
              const SizedBox(width: 20),
              _SocialItem(
                label: 'instagram',
                img: Assets.images.instagramIcon,
              ),
              const SizedBox(width: 20),
              _SocialItem(
                label: 'tiktok',
                img: Assets.images.tiktokIcon,
              ),
              const SizedBox(width: 20),
              _SocialItem(
                label: 'x',
                img: Assets.images.xIcon,
              ),
              const SizedBox(width: 20),
              _SocialItem(
                label: 'linkedin',
                img: Assets.images.unselectedLinkedin,
              ),
            ],
          ),
        ),
        if (selectSocial != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: TextFormField(
              key: ValueKey(selectSocial),
              initialValue: socialLinks[selectSocial],
              onChanged: (value) => ref
                  .read(eventFormControllerProvider.notifier)
                  .socialLink(selectSocial, value),
              onTapOutside: (_) => context.clearFocus(),
              onFieldSubmitted: (_) => context.clearFocus(),
              style: const TextStyle(fontSize: 13, color: colorWhite),
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Insert link here ...',
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          )
      ],
    );
  }
}

class _SocialItem extends ConsumerWidget {
  const _SocialItem({
    required this.label,
    required this.img,
  });

  final String label;
  final AssetGenImage img;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(eventFormControllerProvider);
    var socialLinks = state.socialLinks;
    var selectSocial = state.selectSocial;

    var isSelect = selectSocial == label;
    var selected = socialLinks.containsKey(label);

    return GestureDetector(
      onTap: () => isSelect
          ? ref.read(eventFormControllerProvider.notifier).unSelectSocial()
          : ref.read(eventFormControllerProvider.notifier).selectSocial(label),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelect || selected ? colorRed : null,
          border: isSelect
              ? Border.all(color: colorWhite, width: 1.2)
              : selected
                  ? null
                  : Border.all(color: Colors.white60),
        ),
        padding: EdgeInsets.all(8),
        child: Image.asset(
          img.path,
          color: isSelect || selected ? colorWhite : Colors.white60,
        ),
      ),
    );
  }
}
