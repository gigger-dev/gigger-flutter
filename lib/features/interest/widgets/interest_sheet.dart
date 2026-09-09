import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/interest/providers/interest_provider.dart';
import 'package:mobile_gigger_app/features/interest/widgets/search_textbox.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class InterestSheet extends ConsumerStatefulWidget {
  const InterestSheet({super.key});

  @override
  ConsumerState<InterestSheet> createState() => _InterestSheetState();
}

class _InterestSheetState extends ConsumerState<InterestSheet> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(interestProvider).whenData((v) => v).value;

    var searchList = state?.searchList ?? [];
    var items = state?.searchResultList ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: .04.sh),
          _TopBar(
            onCancel: () {
              ref.read(interestProvider.notifier).clearSearch();
            },
          ),
          SizedBox(height: .05.sh),
          const TextViewWidget(text: 'My interests', textSize: 20),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: searchList.map((e) {
              return _SelectedItem(
                data: e,
                onTap: () {
                  ref.read(interestProvider.notifier).removeSearch(e);
                },
              );
            }).toList(),
          ),
          SizedBox(height: .1.sh),
          if (items.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: TextViewWidget(text: 'Results', textSize: 20),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var data = items[index];

                return _ResultItem(
                  data: data,
                  selected: searchList.contains(data),
                  onTap: () => onAdd(
                    data,
                    state!.selectedList.length,
                    state.searchList.length,
                  ),
                );
              },
            ),
          ),
          SearchTextBox(
            autofocus: true,
            onChanged: (value) async {
              if (value.length > 1) {
                await ref.read(interestProvider.notifier).search(value);
              }
            },
          ),
          SizedBox(
            height: 20 + MediaQuery.of(context).viewInsets.bottom,
          ),
        ],
      ),
    );
  }

  void onAdd(InterestOut data, int selectedList, int searchList) {
    var length = selectedList + searchList;
    if (length >= 5) return;

    ref.read(interestProvider.notifier).addSearch(data);
  }
}

class _SelectedItem extends StatelessWidget {
  const _SelectedItem({
    required this.onTap,
    required this.data,
  });

  final InterestOut data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              colorOrangeRed,
              colorBtnOrangeRed,
            ],
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextViewWidget(text: data.name, textSize: 12),
            const SizedBox(width: 10),
            const Icon(Icons.clear, size: 18),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.onCancel,
  });

  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {
            onCancel();
            context.pop();
          },
          child: const TextViewWidget(text: 'Cancel'),
        ),
        FilledButton(
          onPressed: context.pop,
          child: const TextViewWidget(text: 'Save'),
        ),
      ],
    );
  }
}

class _ResultItem extends StatelessWidget {
  const _ResultItem({
    required this.data,
    required this.onTap,
    required this.selected,
  });

  final bool selected;
  final InterestOut data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(left: 20),
      title: TextViewWidget(text: data.name, textSize: 14),
      trailing: selected
          ? null
          : TextButton(
              onPressed: onTap,
              child: const TextViewWidget(text: 'Add', color: colorRed),
            ),
    );
  }
}
