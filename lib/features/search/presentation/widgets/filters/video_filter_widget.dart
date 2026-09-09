import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/hashtag_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/hashtag_box.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/text_from_label_widget.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/hashtag/hashtag_text_form_field.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:multi_trigger_autocomplete/multi_trigger_autocomplete.dart';

class VideoFilterWidget extends ConsumerStatefulWidget {
  const VideoFilterWidget({super.key});

  @override
  ConsumerState<VideoFilterWidget> createState() => _VideoFilterWidgetState();
}

class _VideoFilterWidgetState extends ConsumerState<VideoFilterWidget> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final keyword = TextEditingController();
  final genre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: .44.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              image: AssetImage(Assets.images.giMaskGroup3.path),
            ),
          ),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorBlack.withOpacity(.4),
                colorBlack,
              ],
              stops: const [.4, 1],
            ),
          ),
        ),
        Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(height: .12.sh),
              const TextViewWidget(text: 'VIDEOS', textSize: 30, height: 1),
              SizedBox(height: .18.sh),
              TextFormLabelWidget(
                label: 'Title',
                controller: title,
                hintText: 'type post title',
              ),
              const SizedBox(height: 24),
              TextFormLabelWidget(
                label: 'Keyword',
                controller: keyword,
                hintText: 'type any keyword',
              ),
              const SizedBox(height: 26),
              HashtagBox(
                title: 'Genre',
                controller: genre,
                hintText: 'type hashtags',
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: GradientFilledButton(title: 'Search', onPressed: onSearch),
        ),
      ],
    );
  }

  void onSearch() {
    context.clearFocus();

    if (!formKey.currentState!.validate()) return;

    var hashtags = ref.read(postFormControllerProvider).hashtags;

    String? _genre;

    if (hashtags.isNotEmpty) {
      _genre = hashtags.firstOrNull?.uuid;
    } else {
      _genre = ref
          .read(hashtagAllControllerProvider)
          .where((e) => e.name == genre.text.trim())
          .firstOrNull
          ?.uuid;
    }

    VideoResultRoute(
      genre: _genre,
      title: title.text.trim(),
      keywords: keyword.text.trim(),
    ).push(context);
  }
}

class HashtagBox extends ConsumerStatefulWidget {
  const HashtagBox({
    super.key,
    this.hintText,
    required this.title,
    required this.controller,
  });

  final String title;
  final String? hintText;
  final TextEditingController controller;

  @override
  ConsumerState<HashtagBox> createState() => _HashtagBoxState();
}

class _HashtagBoxState extends ConsumerState<HashtagBox> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextViewWidget(text: widget.title, textSize: 12)),
        SizedBox(
          width: 240,
          // child: DropdownWithSearch(
          //   items: [],
          //   onChanged: (value) {},
          //   title: 'title',
          //   placeHolder: 'placeHolder',
          //   selected: null,
          //   label: 'label',
          // ),
          child: MultiTriggerAutocomplete(
            focusNode: FocusNode(),
            textEditingController: widget.controller,
            debounceDuration: Duration(milliseconds: 500),
            autocompleteTriggers: [
              AutocompleteTrigger(
                trigger: '#',
                triggerOnlyAtStart: true,
                minimumRequiredCharacters: 2,
                triggerOnlyAfterSpace: false,
                optionsViewBuilder: (context, autocompleteQuery, controller) {
                  return HashtagAutocompleteOptions(
                    query: autocompleteQuery.query,
                    onHashtagTap: (hashtag) {
                      final autocomplete = MultiTriggerAutocomplete.of(context);
                      autocomplete.acceptAutocompleteOption(hashtag.name);

                      ref
                          .read(postFormControllerProvider.notifier)
                          .hashTag(hashtag, isOnly: true);

                      context.clearFocus();
                    },
                  );
                },
              ),
            ],
            fieldViewBuilder: (context, controller, focusNode) {
              return HashtagTextFormField(
                isMultiple: false,
                focusNode: focusNode,
                onChanged: onChanged,
                controller: controller,
                onSubmitted: (value) {
                  onChanged(value);
                  context.clearFocus();
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hintText,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      var query = value;

      if (value.contains(' ')) {
        query = value.split(' ').last;
      }

      ref
          .read(hashtagControllerProvider.notifier)
          .search(query.replaceFirst('#', ''));
    });
  }
}
