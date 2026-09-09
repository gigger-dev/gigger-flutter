import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/utils/get_location_data.dart';

import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/post_form_screen.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/hashtag_box.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/user_tag_box.dart';

class PostFormData extends ConsumerWidget {
  const PostFormData({
    super.key,
    required this.title,
    required this.hashtag,
    required this.caption,
    required this.userTag,
    required this.musicTitle,
    required this.place,
  });

  final TextEditingController title;
  final TextEditingController caption;
  final TextEditingController hashtag;
  final TextEditingController userTag;
  final TextEditingController musicTitle;
  final TextEditingController place;

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
            controller: title,
            hintText: 'Post Title ...',
            textCapitalization: TextCapitalization.sentences,
          ),
          SizedBox(height: 24),
          PostTextBox(
            maxLines: 6,
            controller: caption,
            hintText: 'Write Caption ...',
            textCapitalization: TextCapitalization.sentences,
          ),
          SizedBox(height: 24),
          PostTextBox(
            maxLines: 6,
            required: false,
            controller: musicTitle,
            hintText: 'Music Title ...',
            textCapitalization: TextCapitalization.sentences,
          ),
          SizedBox(height: 24),
          PostTextBox(
            readOnly: true,
            required: false,
            controller: place,
            hintText: 'Place ...',
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
          SizedBox(height: 36),
          PostListTile(
            // isDisable: true,
            value: state.isPrivate,
            title: 'Private, not showed in Fab9',
            subtitle: 'Saved just for you into the archive',
            onChanged: (v) {
              SheetUtils.proComingSoonSheet(context);
              // ref.read(postFormControllerProvider.notifier).isPrivate(v);
            },
          ),
          SizedBox(height: 24),
          PostListTile(
            // isDisable: true,
            value: state.isMembershipOnly,
            title: 'Membership Content',
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
            // isDisable: true,
            value: state.isOnlyForFollowers,
            title: 'For my followers only',
            subtitle: 'Make this visible only for your followers',
            onChanged: (v) {
              SheetUtils.proComingSoonSheet(context);
              // ref
              //     .read(postFormControllerProvider.notifier)
              //     .isOnlyForFollowers(v);
            },
          ),
        ],
      ),
    );
  }
}
