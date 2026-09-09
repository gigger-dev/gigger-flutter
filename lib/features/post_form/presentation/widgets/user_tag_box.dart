import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/user_tag_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
import 'package:multi_trigger_autocomplete/multi_trigger_autocomplete.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/hashtag/hashtag_text_form_field.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class UserTagBox extends ConsumerStatefulWidget {
  const UserTagBox({
    super.key,
    required this.title,
    required this.controller,
    this.onSelected,
    this.isRequired = true,
  });

  final String title;
  final bool isRequired;
  final TextEditingController controller;
  final ValueChanged<ProfileFewerDetailsOut>? onSelected;

  @override
  ConsumerState<UserTagBox> createState() => _UserTagBoxState();
}

class _UserTagBoxState extends ConsumerState<UserTagBox> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var profileUuid = ref.watch(profileControllerProvider).value!.uuid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextViewWidget(text: widget.title, color: colorRed, textSize: 14),
        const SizedBox(height: 15),
        MultiTriggerAutocomplete(
          focusNode: FocusNode(),
          textEditingController: widget.controller,
          autocompleteTriggers: [
            AutocompleteTrigger(
              trigger: '@',
              minimumRequiredCharacters: 2,
              optionsViewBuilder: (context, autocompleteQuery, controller) {
                return HashtagAutocompleteOptions(
                  query: autocompleteQuery.query,
                  onTap: (hashtag) {
                    final autocomplete = MultiTriggerAutocomplete.of(context);
                    autocomplete.acceptAutocompleteOption(
                      hashtag.account.username.replaceAll(' ', ''),
                    );

                    if (widget.onSelected != null) {
                      widget.onSelected?.call(hashtag);
                    } else {
                      ref
                          .read(postFormControllerProvider.notifier)
                          .taggedProfile(hashtag.uuid);
                    }

                    context.clearFocus();
                  },
                );
              },
            ),
          ],
          fieldViewBuilder: (context, controller, focusNode) {
            return HashtagTextFormField(
              trigger: '@',
              focusNode: focusNode,
              controller: controller,
              validator: !widget.isRequired
                  ? null
                  : (v) => (v?.isEmpty ?? true) ? 'required' : null,
              onSubmitted: (value) {
                onChanged(value, profileUuid);
                context.clearFocus();
              },
              decoration: InputDecoration(
                isDense: true,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                hintText: 'Mention another user',
              ),
              onChanged: (value) => onChanged(value, profileUuid),
            );
          },
        ),
      ],
    );
  }

  void onChanged(String value, String profileUuid) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      var query = value;

      if (value.contains(' ')) {
        query = value.split(' ').last;
      }

      ref
          .read(userTagControllerProvider(profileUuid).notifier)
          .search(query.replaceFirst('@', ''));
    });
  }
}

class HashtagAutocompleteOptions extends ConsumerWidget {
  const HashtagAutocompleteOptions({
    super.key,
    required this.query,
    required this.onTap,
  });

  final String query;
  final ValueSetter<ProfileFewerDetailsOut> onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var all = ref.watch(userTagAllControllerProvider);

    final items = all.where((it) {
      final normalizedOption = it.account.username.toLowerCase();
      final normalizedQuery = query.toLowerCase();
      return normalizedOption.contains(normalizedQuery);
    });

    if (items.isEmpty) return const SizedBox.shrink();

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
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, i) {
            final data = items.elementAt(i);
            return ListTile(
              dense: true,
              title: Text(data.account.username),
              onTap: () => onTap(data),
            );
          },
        ),
      ),
    );
  }
}
