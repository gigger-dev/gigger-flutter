import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/utils/get_location_data.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';

import 'package:mobile_gigger_app/features/post_form/presentation/post_form_screen.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/call_to_action_btn.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/hashtag_box.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/looking_for_widget.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/performer_widget.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class GiglistFormData extends ConsumerWidget {
  const GiglistFormData({
    super.key,
    required this.hashtag,
    required this.title,
    required this.caption,
    required this.place,
    required this.wageRequested,
    required this.availability,
  });

  final TextEditingController hashtag;
  final TextEditingController title;
  final TextEditingController place;
  final TextEditingController caption;
  final TextEditingController wageRequested;
  final TextEditingController availability;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(postFormControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LookingForWidget(
          isLookingFor: state.isLookingFor,
          onChanged: (v) =>
              ref.read(postFormControllerProvider.notifier).isLookingFor(v),
        ),
        const SizedBox(height: 30),
        PerformerWidget(
          isPerformer: state.isPerformer,
          onChanged: (v) =>
              ref.read(postFormControllerProvider.notifier).isPerformer(v),
        ),
        const SizedBox(height: 35),
        HashtagBox(
          controller: hashtag,
          title: 'Add Music Genre Hashtags (at least one)',
        ),
        const SizedBox(height: 24),
        PostTextBox(
          maxLines: 6,
          controller: title,
          hintText: 'Title of annoucement …',
          textCapitalization: TextCapitalization.sentences,
        ),
        const SizedBox(height: 24),
        PostTextBox(
          maxLines: 6,
          controller: caption,
          textCapitalization: TextCapitalization.sentences,
          hintText:
              'Describe ... ("Hello, I am the right choice for your metal band")',
        ),
        const SizedBox(height: 24),
        PostTextBox(
          readOnly: true,
          required: false,
          controller: place,
          hintText: 'Place ...( it will open the maps screen)',
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
        const SizedBox(height: 24),
        PostTextBox(
          required: false,
          controller: wageRequested,
          keyboardType: TextInputType.number,
          prefix: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextViewWidget(text: '€'),
          ),
          hintText: state.isPerformer
              ? 'Wage requested ... (not mandatory)'
              : !state.isLookingFor
                  ? 'Price ... (not mandatory)'
                  : 'Max amount I can offer ... (not mandatory)',
        ),
        if (state.isPerformer) ...[
          const SizedBox(height: 24),
          PostTextBox(
            readOnly: true,
            required: false,
            controller: availability,
            hintText:
                'Availability ... (not mandatory, will open calendar or selector)',
            onTap: () => SheetUtils.newComingSoonSheet(context),
          ),
        ],
        const SizedBox(height: 24),
        CallToActionBtn(),
        const SizedBox(height: 40),
      ],
    );
  }
}
