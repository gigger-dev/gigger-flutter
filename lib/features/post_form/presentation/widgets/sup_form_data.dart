import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/utils/get_location_data.dart';

import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/post_form_screen.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/hashtag_box.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/user_tag_box.dart';

class SupFormData extends ConsumerWidget {
  const SupFormData({
    super.key,
    required this.caption,
    required this.hashtag,
    required this.place,
    required this.userTag,
  });

  final TextEditingController caption;
  final TextEditingController hashtag;
  final TextEditingController place;
  final TextEditingController userTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(postFormControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostTextBox(
            maxLines: 6,
            maxLength: 150,
            controller: caption,
            validator: (v) => v!.length < 2 ? 'at least 2 characters' : null,
            textCapitalization: TextCapitalization.sentences,
            hintText: 'Write text (remains visible, max 150 characters)',
          ),
          SizedBox(height: 24),
          PostTextBox(
            controller: place,
            hintText: 'Place ...',
            required: false,
            readOnly: true,
            onTap: () async {
              var r = await SheetUtils.placeSheet(
                context,
                lat: state.lat,
                long: state.long,
              );
              if (r != null) {
                ref.read(postFormControllerProvider.notifier).latLng(r.latLng);
                place.text = getLocationData(r.placemark);
                // '${r.placemark.street}, ${r.placemark.subAdministrativeArea}, ${r.placemark.administrativeArea}';
              }
            },
          ),
          SizedBox(height: 24),
          HashtagBox(
            controller: hashtag,
            title: '# Add Hashtags (at least one)',
          ),
          SizedBox(height: 24),
          UserTagBox(
            isRequired: false,
            controller: userTag,
            title: '@ Tag Giggers to this content',
          ),
          // const TextViewWidget(
          //   text: '@ Tag Giggers to this content',
          //   color: colorRed,
          //   textSize: SizeUtils.textSizeExtraSmall,
          // ),
          // const SizedBox(height: 15),
          // PostTextBox(
          //   required: false,
          //   readOnly: true,
          //   controller: TextEditingController(),
          //   hintText: 'Mention another user',
          // ),
          SizedBox(height: 36),
          PostListTile(
            // isDisable: true,
            title: 'Membership Content',
            value: state.isMembershipOnly,
            subtitle: 'Select the exclusive membership for this content',
            onChanged: (v) {
              SheetUtils.proComingSoonSheet(context);
              // ref
              //   .read(postFormControllerProvider.notifier)
              //   .isMembershipOnly(v);
            },
          ),
          SizedBox(height: 24),
          PostListTile(
            title: 'For my followers only',
            value: state.isOnlyForFollowers,
            subtitle: 'Make this visible only for your followers',
            onChanged: (v) {
              SheetUtils.proComingSoonSheet(context);
              // ref
              //   .read(postFormControllerProvider.notifier)
              //   .isOnlyForFollowers(v);
            },
          ),
        ],
      ),
    );
  }
}
