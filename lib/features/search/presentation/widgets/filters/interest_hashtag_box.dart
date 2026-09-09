import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/features/interest/providers/interest_provider.dart';
import 'package:mobile_gigger_app/features/search/controllers/gigger_filter_controller.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';
import 'package:multi_trigger_autocomplete/multi_trigger_autocomplete.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/hashtag/hashtag_text_form_field.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class InterestHashtagBox extends ConsumerStatefulWidget {
  const InterestHashtagBox({
    super.key,
    required this.title,
    this.hintText,
    required this.controller,
  });

  final String title;
  final String? hintText;
  final TextEditingController controller;

  @override
  ConsumerState<InterestHashtagBox> createState() => _GenreHashtagBoxState();
}

class _GenreHashtagBoxState extends ConsumerState<InterestHashtagBox> {
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
          child: MultiTriggerAutocomplete(
            focusNode: FocusNode(),
            textEditingController: widget.controller,
            autocompleteTriggers: [
              AutocompleteTrigger(
                trigger: '#',
                triggerOnlyAtStart: true,
                triggerOnlyAfterSpace: false,
                minimumRequiredCharacters: 2,
                optionsViewBuilder: (context, autocompleteQuery, controller) {
                  return HashtagAutocompleteOptions(
                    query: autocompleteQuery.query,
                    onHashtagTap: (hashtag) {
                      final autocomplete = MultiTriggerAutocomplete.of(context);
                      autocomplete.acceptAutocompleteOption(hashtag.name);

                      ref
                          .read(giggerFilterControllerProvider.notifier)
                          .interest(hashtag);

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
                decoratedStyle: TextStyle(),
                onSubmitted: (value) {
                  onChanged(value);
                  context.clearFocus();
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hintText,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  hintStyle: TextStyle(color: colorTextGrey, fontSize: 12),
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

      ref.read(interestProvider.notifier).search(query.replaceFirst('#', ''));
    });
  }
}

class HashtagAutocompleteOptions extends ConsumerWidget {
  const HashtagAutocompleteOptions({
    super.key,
    required this.query,
    required this.onHashtagTap,
  });

  final String query;
  final ValueSetter<InterestOut> onHashtagTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var hashtag =
        ref.watch(interestProvider).valueOrNull?.searchResultList ?? [];

    final hashtags = hashtag.where((it) {
      final normalizedOption = it.name.toLowerCase();
      final normalizedQuery = query.toLowerCase();
      return normalizedOption.contains(normalizedQuery);
    });

    if (hashtags.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: LimitedBox(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: hashtags.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, i) {
            final hashtag = hashtags.elementAt(i);
            return ListTile(
              dense: true,
              title: Text(hashtag.name),
              onTap: () => onHashtagTap(hashtag),
            );
          },
        ),
      ),
    );
  }
}
